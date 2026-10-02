import 'package:budget_buddy/core/database/app_database.dart';
import 'package:budget_buddy/features/accounts/domain/account.dart';
import 'package:budget_buddy/features/accounts/domain/account_repository.dart';
import 'package:drift/drift.dart';

class DriftAccountRepository implements AccountRepository {
  DriftAccountRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Account> getDefault() async {
    final query = _db.select(_db.accounts)
      ..where((a) => a.deletedAt.isNull())
      ..orderBy([(a) => OrderingTerm.asc(a.id)])
      ..limit(1);
    final row = await query.getSingle();
    return Account(
      id: row.id,
      currencyCode: row.currencyCode,
      name: row.name,
      systemKey: row.systemKey,
    );
  }
}
