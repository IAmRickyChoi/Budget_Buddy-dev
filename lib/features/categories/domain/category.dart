import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required TransactionType type,
    String? name,
    String? systemKey,
  }) = _Category;
}
