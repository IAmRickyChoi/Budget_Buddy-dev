// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 화면과 Notifier는 이 Provider로 인터페이스만 받는다.
/// 구현체(Drift)를 바꾸거나 테스트용 가짜로 갈아끼울 때 여기만 고치면 된다.

@ProviderFor(transactionRepository)
final transactionRepositoryProvider = TransactionRepositoryProvider._();

/// 화면과 Notifier는 이 Provider로 인터페이스만 받는다.
/// 구현체(Drift)를 바꾸거나 테스트용 가짜로 갈아끼울 때 여기만 고치면 된다.

final class TransactionRepositoryProvider
    extends
        $FunctionalProvider<
          TransactionRepository,
          TransactionRepository,
          TransactionRepository
        >
    with $Provider<TransactionRepository> {
  /// 화면과 Notifier는 이 Provider로 인터페이스만 받는다.
  /// 구현체(Drift)를 바꾸거나 테스트용 가짜로 갈아끼울 때 여기만 고치면 된다.
  TransactionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransactionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRepository create(Ref ref) {
    return transactionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRepository>(value),
    );
  }
}

String _$transactionRepositoryHash() =>
    r'78244cdf1f73d1d9dd6d0020e29608852925355e';
