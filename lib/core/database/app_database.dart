import 'package:budget_buddy/core/database/tables.dart';
import 'package:budget_buddy/core/sync/sync_state.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Accounts, Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  /// [executor]를 넘기지 않으면 기기에 'budget_buddy' DB 파일을 연다.
  /// 테스트에서는 `NativeDatabase.memory()`를 넘긴다.
  ///
  /// [defaultCurrencyCode]는 DB를 처음 만들 때 기본 계좌의 통화로 쓴다.
  AppDatabase({QueryExecutor? executor, this.defaultCurrencyCode = 'USD'})
    : super(executor ?? driftDatabase(name: 'budget_buddy'));

  final String defaultCurrencyCode;

  /// 스키마를 바꾸면 올리고 [migration]에 onUpgrade 단계를 추가한다.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedDefaults();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _seedDefaults() async {
    const uuid = Uuid();
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    await into(accounts).insert(
      AccountsCompanion.insert(
        id: uuid.v7(),
        updatedAt: now,
        systemKey: const Value('cash'),
        currencyCode: defaultCurrencyCode,
      ),
    );

    await batch((b) {
      for (final (index, (key, type)) in defaultCategories.indexed) {
        b.insert(
          categories,
          CategoriesCompanion.insert(
            id: uuid.v7(),
            updatedAt: now,
            systemKey: Value(key),
            type: type,
            sortOrder: Value(index),
          ),
        );
      }
    });
  }

  static const defaultCategories = <(String, TransactionType)>[
    ('food', TransactionType.expense),
    ('cafe', TransactionType.expense),
    ('transport', TransactionType.expense),
    ('shopping', TransactionType.expense),
    ('housing', TransactionType.expense),
    ('health', TransactionType.expense),
    ('entertainment', TransactionType.expense),
    ('other_expense', TransactionType.expense),
    ('salary', TransactionType.income),
    ('bonus', TransactionType.income),
    ('other_income', TransactionType.income),
  ];
}
