import 'package:budget_buddy/core/sync/sync_state.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:drift/drift.dart';

/// 동기화 대상 테이블이 공통으로 갖는 컬럼. (docs/architecture.md 6.1)
mixin SyncColumns on Table {
  /// 클라이언트에서 만드는 UUID v7. 오프라인에서도 충돌 없이 생성된다.
  TextColumn get id => text()();

  /// 로컬에서 마지막으로 바뀐 시각 (UTC 밀리초).
  IntColumn get updatedAt => integer()();

  /// 서버가 기록한 시각. pull 커서로 쓴다.
  IntColumn get serverUpdatedAt => integer().nullable()();

  /// 소프트 삭제 시각. 지운 사실을 다른 기기에 알리려면 행을 남겨야 한다.
  IntColumn get deletedAt => integer().nullable()();

  IntColumn get syncState =>
      intEnum<SyncState>().withDefault(Constant(SyncState.pending.index))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// 기본 제공 행은 [systemKey]만 저장하고 이름은 화면에서 번역한다.
/// 사용자가 만든 행은 [name]을 저장한다. 그래야 기기 언어를 바꿔도
/// "식비"가 "Food"로 따라 바뀐다.
@DataClassName('AccountRow')
class Accounts extends Table with SyncColumns {
  TextColumn get name => text().nullable()();
  TextColumn get systemKey => text().nullable()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
}

@DataClassName('CategoryRow')
class Categories extends Table with SyncColumns {
  TextColumn get name => text().nullable()();
  TextColumn get systemKey => text().nullable()();
  IntColumn get type => intEnum<TransactionType>()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

@DataClassName('TransactionRow')
class Transactions extends Table with SyncColumns {
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  IntColumn get type => intEnum<TransactionType>()();

  /// 통화의 최소 단위 정수. 항상 양수이고 부호는 [type]이 정한다.
  IntColumn get amountMinor => integer()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();

  /// 사용자 기준 날짜 'yyyy-MM-dd'. 시간대가 바뀌어도 날짜가 흔들리지 않게
  /// UTC 시각과 따로 저장한다. (docs/architecture.md 8장)
  TextColumn get occurredOn => text().withLength(min: 10, max: 10)();
  TextColumn get note => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer()();
}
