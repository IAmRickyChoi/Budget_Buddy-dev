import 'package:budget_buddy/core/database/app_database.dart';
import 'package:budget_buddy/core/money/money.dart';
import 'package:budget_buddy/core/sync/sync_state.dart';
import 'package:budget_buddy/features/accounts/data/drift_account_repository.dart';
import 'package:budget_buddy/features/transactions/data/drift_transaction_repository.dart';
import 'package:budget_buddy/features/transactions/domain/transaction.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late DriftTransactionRepository repository;
  late String accountId;

  setUp(() async {
    db = createTestDatabase();
    repository = DriftTransactionRepository(
      db,
      clock: () => DateTime.utc(2026, 10, 2, 12),
    );
    accountId = (await DriftAccountRepository(db).getDefault()).id;
  });

  tearDown(() => db.close());

  NewTransaction newTx(
    int cents,
    DateTime day, {
    TransactionType type = TransactionType.expense,
  }) => NewTransaction(
    accountId: accountId,
    type: type,
    amount: Money(cents, 'USD'),
    occurredOn: day,
  );

  test('seeds a default account and categories on first open', () async {
    final account = await DriftAccountRepository(db).getDefault();
    expect(account.currencyCode, 'USD');
    expect(account.systemKey, 'cash');

    final categories = await db.select(db.categories).get();
    expect(categories, hasLength(AppDatabase.defaultCategories.length));
  });

  test('watchMonth returns only that month, newest first', () async {
    await repository.add(newTx(100, DateTime(2026, 9, 30)));
    // 10월 1일과 11월 1일: 월 경계
    await repository.add(newTx(200, DateTime(2026, 10)));
    await repository.add(newTx(300, DateTime(2026, 10, 31)));
    await repository.add(newTx(400, DateTime(2026, 11)));

    final october = await repository.watchMonth(DateTime(2026, 10)).first;

    expect(october.map((t) => t.amount.amountMinor), [300, 200]);
  });

  test('monthly totals are summed per type by SQL', () async {
    await repository.add(newTx(1000, DateTime(2026, 10, 3)));
    await repository.add(newTx(250, DateTime(2026, 10, 4)));
    await repository.add(
      newTx(5000, DateTime(2026, 10, 5), type: TransactionType.income),
    );

    final totals = await repository
        .watchMonthlyTotals(DateTime(2026, 10))
        .first;

    expect(totals, hasLength(1));
    expect(totals.single.expense, const Money(1250, 'USD'));
    expect(totals.single.income, const Money(5000, 'USD'));
    expect(totals.single.balance, const Money(3750, 'USD'));
  });

  test('new rows are marked pending for the future sync step', () async {
    final tx = await repository.add(newTx(100, DateTime(2026, 10, 2)));

    final row = await (db.select(
      db.transactions,
    )..where((t) => t.id.equals(tx.id))).getSingle();
    expect(row.syncState, SyncState.pending);
    expect(row.occurredOn, '2026-10-02');
    expect(row.updatedAt, DateTime.utc(2026, 10, 2, 12).millisecondsSinceEpoch);
  });

  test('delete is soft: the row stays with deletedAt set', () async {
    final tx = await repository.add(newTx(100, DateTime(2026, 10, 2)));

    await repository.delete(tx.id);

    expect(await repository.watchMonth(DateTime(2026, 10)).first, isEmpty);
    final row = await (db.select(
      db.transactions,
    )..where((t) => t.id.equals(tx.id))).getSingle();
    expect(row.deletedAt, isNotNull);
  });

  test('watchMonth emits again when data changes', () async {
    final emissions = repository
        .watchMonth(DateTime(2026, 10))
        .map((list) => list.length);
    final expectation = expectLater(emissions, emitsInOrder([0, 1]));

    await pumpEventQueue();
    await repository.add(newTx(100, DateTime(2026, 10, 2)));

    await expectation;
  });

  test('rejects non-positive amounts', () {
    expect(
      () => repository.add(newTx(0, DateTime(2026, 10, 2))),
      throwsArgumentError,
    );
  });
}
