import 'package:budget_buddy/core/database/database_provider.dart';
import 'package:budget_buddy/features/categories/data/drift_category_repository.dart';
import 'package:budget_buddy/features/categories/domain/category.dart';
import 'package:budget_buddy/features/categories/domain/category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_providers.g.dart';

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) =>
    DriftCategoryRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<Category>> categories(Ref ref) =>
    ref.watch(categoryRepositoryProvider).watchAll();
