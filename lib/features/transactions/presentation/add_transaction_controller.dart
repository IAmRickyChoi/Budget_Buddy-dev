import 'package:budget_buddy/features/transactions/data/transaction_providers.dart';
import 'package:budget_buddy/features/transactions/domain/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_transaction_controller.g.dart';

/// 거래 저장 버튼의 상태(대기·저장 중·실패)를 들고 있는 Notifier.
///
/// 폼 입력값 자체는 화면의 로컬 상태로 두고, 여기서는 "저장"이라는
/// 비동기 작업과 그 결과만 다룬다. 그래야 화면은 로딩 표시와
/// 오류 처리만 신경 쓰면 된다.
@riverpod
class AddTransactionController extends _$AddTransactionController {
  @override
  FutureOr<void> build() {}

  /// 성공하면 true. 실패하면 state에 오류가 남는다.
  Future<bool> submit(NewTransaction input) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(transactionRepositoryProvider).add(input),
    );
    if (!ref.mounted) return false;
    state = result;
    return !result.hasError;
  }
}
