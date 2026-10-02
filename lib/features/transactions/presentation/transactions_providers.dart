import 'package:budget_buddy/features/categories/data/category_providers.dart';
import 'package:budget_buddy/features/categories/domain/category.dart';
import 'package:budget_buddy/features/transactions/data/transaction_providers.dart';
import 'package:budget_buddy/features/transactions/domain/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_providers.g.dart';

/// 내역 화면에서 보고 있는 달. 항상 그 달의 1일로 맞춘다.
@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month);
  }

  void previous() => state = DateTime(state.year, state.month - 1);

  void next() => state = DateTime(state.year, state.month + 1);
}

typedef TransactionListItem = ({Transaction transaction, Category? category});

/// 선택한 달의 거래에 카테고리를 붙인 목록.
///
/// Drift의 watch 스트림을 그대로 흘려보내므로, 거래를 추가·삭제하면
/// 이 화면에 따로 "새로고침"을 알리지 않아도 목록이 바뀐다.
@riverpod
Stream<List<TransactionListItem>> monthTransactions(Ref ref) async* {
  final month = ref.watch(selectedMonthProvider);
  final categories = await ref.watch(categoriesProvider.future);
  final byId = {for (final c in categories) c.id: c};

  yield* ref
      .watch(transactionRepositoryProvider)
      .watchMonth(month)
      .map(
        (transactions) => [
          for (final t in transactions)
            (transaction: t, category: byId[t.categoryId]),
        ],
      );
}

@riverpod
Stream<List<MonthlyTotal>> monthlyTotals(Ref ref) {
  final month = ref.watch(selectedMonthProvider);
  return ref.watch(transactionRepositoryProvider).watchMonthlyTotals(month);
}
