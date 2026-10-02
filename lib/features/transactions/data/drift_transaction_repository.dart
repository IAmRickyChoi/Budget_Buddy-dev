import 'package:budget_buddy/core/database/app_database.dart';
import 'package:budget_buddy/core/database/date_key.dart';
import 'package:budget_buddy/core/money/money.dart';
import 'package:budget_buddy/core/sync/sync_state.dart';
import 'package:budget_buddy/features/transactions/domain/transaction.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_repository.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class DriftTransactionRepository implements TransactionRepository {
  /// [clock]은 테스트에서 시각을 고정할 때 넘긴다.
  DriftTransactionRepository(this._db, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _clock;
  static const _uuid = Uuid();

  int get _nowMs => _clock().toUtc().millisecondsSinceEpoch;

  Expression<bool> _inMonth($TransactionsTable t, DateTime month) {
    final (start, end) = DateKey.monthRange(month);
    return t.deletedAt.isNull() &
        t.occurredOn.isBiggerOrEqualValue(start) &
        t.occurredOn.isSmallerThanValue(end);
  }

  @override
  Stream<List<Transaction>> watchMonth(DateTime month) {
    final query = _db.select(_db.transactions)
      ..where((t) => _inMonth(t, month))
      ..orderBy([
        (t) => OrderingTerm.desc(t.occurredOn),
        (t) => OrderingTerm.desc(t.createdAt),
      ]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  @override
  Stream<List<MonthlyTotal>> watchMonthlyTotals(DateTime month) {
    // 합계는 SQL의 SUM ... GROUP BY로 DB가 계산한다.
    // 거래를 전부 메모리로 가져와 더하는 것보다 빠르고 코드도 짧다.
    final t = _db.transactions;
    final sum = t.amountMinor.sum();
    final query = _db.selectOnly(t)
      ..addColumns([t.currencyCode, t.type, sum])
      ..where(_inMonth(t, month))
      ..groupBy([t.currencyCode, t.type]);

    return query.watch().map((rows) {
      final totals = <String, MonthlyTotal>{};
      for (final row in rows) {
        final currency = row.read(t.currencyCode)!;
        final type = t.type.converter.fromSql(row.read(t.type));
        final amount = Money(row.read(sum) ?? 0, currency);
        final current =
            totals[currency] ??
            MonthlyTotal(
              income: Money.zero(currency),
              expense: Money.zero(currency),
            );
        totals[currency] = switch (type) {
          TransactionType.income => current.copyWith(income: amount),
          TransactionType.expense => current.copyWith(expense: amount),
        };
      }
      return totals.values.toList();
    });
  }

  @override
  Future<Transaction> add(NewTransaction input) async {
    if (input.amount.amountMinor <= 0) {
      throw ArgumentError.value(input.amount, 'amount', 'must be positive');
    }
    final now = _nowMs;
    final id = _uuid.v7();
    await _db
        .into(_db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            updatedAt: now,
            createdAt: now,
            accountId: input.accountId,
            categoryId: Value(input.categoryId),
            type: input.type,
            amountMinor: input.amount.amountMinor,
            currencyCode: input.amount.currencyCode,
            occurredOn: DateKey.of(input.occurredOn),
            note: Value(input.note.trim()),
          ),
        );
    return Transaction(
      id: id,
      accountId: input.accountId,
      categoryId: input.categoryId,
      type: input.type,
      amount: input.amount,
      occurredOn: DateTime(
        input.occurredOn.year,
        input.occurredOn.month,
        input.occurredOn.day,
      ),
      note: input.note.trim(),
    );
  }

  @override
  Future<void> delete(String id) async {
    final now = _nowMs;
    await (_db.update(_db.transactions)..where((t) => t.id.equals(id))).write(
      TransactionsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        syncState: const Value(SyncState.pending),
      ),
    );
  }

  Transaction _toEntity(TransactionRow row) => Transaction(
    id: row.id,
    accountId: row.accountId,
    categoryId: row.categoryId,
    type: row.type,
    amount: Money(row.amountMinor, row.currencyCode),
    occurredOn: DateKey.parse(row.occurredOn),
    note: row.note,
  );
}
