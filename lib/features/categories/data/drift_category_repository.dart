import 'package:budget_buddy/core/database/app_database.dart';
import 'package:budget_buddy/features/categories/domain/category.dart';
import 'package:budget_buddy/features/categories/domain/category_repository.dart';
import 'package:drift/drift.dart';

class DriftCategoryRepository implements CategoryRepository {
  DriftCategoryRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Category>> watchAll() {
    final query = _db.select(_db.categories)
      ..where((c) => c.deletedAt.isNull())
      ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          Category(
            id: row.id,
            type: row.type,
            name: row.name,
            systemKey: row.systemKey,
          ),
      ],
    );
  }
}
