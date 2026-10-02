// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 거래 저장 버튼의 상태(대기·저장 중·실패)를 들고 있는 Notifier.
///
/// 폼 입력값 자체는 화면의 로컬 상태로 두고, 여기서는 "저장"이라는
/// 비동기 작업과 그 결과만 다룬다. 그래야 화면은 로딩 표시와
/// 오류 처리만 신경 쓰면 된다.

@ProviderFor(AddTransactionController)
final addTransactionControllerProvider = AddTransactionControllerProvider._();

/// 거래 저장 버튼의 상태(대기·저장 중·실패)를 들고 있는 Notifier.
///
/// 폼 입력값 자체는 화면의 로컬 상태로 두고, 여기서는 "저장"이라는
/// 비동기 작업과 그 결과만 다룬다. 그래야 화면은 로딩 표시와
/// 오류 처리만 신경 쓰면 된다.
final class AddTransactionControllerProvider
    extends $AsyncNotifierProvider<AddTransactionController, void> {
  /// 거래 저장 버튼의 상태(대기·저장 중·실패)를 들고 있는 Notifier.
  ///
  /// 폼 입력값 자체는 화면의 로컬 상태로 두고, 여기서는 "저장"이라는
  /// 비동기 작업과 그 결과만 다룬다. 그래야 화면은 로딩 표시와
  /// 오류 처리만 신경 쓰면 된다.
  AddTransactionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTransactionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTransactionControllerHash();

  @$internal
  @override
  AddTransactionController create() => AddTransactionController();
}

String _$addTransactionControllerHash() =>
    r'f3ebbdb8ccdc910c7e8775ccb23c458a5eed256b';

/// 거래 저장 버튼의 상태(대기·저장 중·실패)를 들고 있는 Notifier.
///
/// 폼 입력값 자체는 화면의 로컬 상태로 두고, 여기서는 "저장"이라는
/// 비동기 작업과 그 결과만 다룬다. 그래야 화면은 로딩 표시와
/// 오류 처리만 신경 쓰면 된다.

abstract class _$AddTransactionController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
