import 'package:budget_buddy/features/categories/domain/category.dart';

abstract interface class CategoryRepository {
  /// 지워지지 않은 카테고리를 정렬 순서대로.
  Stream<List<Category>> watchAll();
}
