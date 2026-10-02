// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 내역 화면에서 보고 있는 달. 항상 그 달의 1일로 맞춘다.

@ProviderFor(SelectedMonth)
final selectedMonthProvider = SelectedMonthProvider._();

/// 내역 화면에서 보고 있는 달. 항상 그 달의 1일로 맞춘다.
final class SelectedMonthProvider
    extends $NotifierProvider<SelectedMonth, DateTime> {
  /// 내역 화면에서 보고 있는 달. 항상 그 달의 1일로 맞춘다.
  SelectedMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedMonthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedMonthHash();

  @$internal
  @override
  SelectedMonth create() => SelectedMonth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedMonthHash() => r'2b73854e49037140c36c6d4f84b2d682f9a40d06';

/// 내역 화면에서 보고 있는 달. 항상 그 달의 1일로 맞춘다.

abstract class _$SelectedMonth extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 선택한 달의 거래에 카테고리를 붙인 목록.
///
/// Drift의 watch 스트림을 그대로 흘려보내므로, 거래를 추가·삭제하면
/// 이 화면에 따로 "새로고침"을 알리지 않아도 목록이 바뀐다.

@ProviderFor(monthTransactions)
final monthTransactionsProvider = MonthTransactionsProvider._();

/// 선택한 달의 거래에 카테고리를 붙인 목록.
///
/// Drift의 watch 스트림을 그대로 흘려보내므로, 거래를 추가·삭제하면
/// 이 화면에 따로 "새로고침"을 알리지 않아도 목록이 바뀐다.

final class MonthTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TransactionListItem>>,
          List<TransactionListItem>,
          Stream<List<TransactionListItem>>
        >
    with
        $FutureModifier<List<TransactionListItem>>,
        $StreamProvider<List<TransactionListItem>> {
  /// 선택한 달의 거래에 카테고리를 붙인 목록.
  ///
  /// Drift의 watch 스트림을 그대로 흘려보내므로, 거래를 추가·삭제하면
  /// 이 화면에 따로 "새로고침"을 알리지 않아도 목록이 바뀐다.
  MonthTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthTransactionsHash();

  @$internal
  @override
  $StreamProviderElement<List<TransactionListItem>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TransactionListItem>> create(Ref ref) {
    return monthTransactions(ref);
  }
}

String _$monthTransactionsHash() => r'10c3f92fec934f5ad3fddce725376e9fa583ef00';

@ProviderFor(monthlyTotals)
final monthlyTotalsProvider = MonthlyTotalsProvider._();

final class MonthlyTotalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MonthlyTotal>>,
          List<MonthlyTotal>,
          Stream<List<MonthlyTotal>>
        >
    with
        $FutureModifier<List<MonthlyTotal>>,
        $StreamProvider<List<MonthlyTotal>> {
  MonthlyTotalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlyTotalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlyTotalsHash();

  @$internal
  @override
  $StreamProviderElement<List<MonthlyTotal>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MonthlyTotal>> create(Ref ref) {
    return monthlyTotals(ref);
  }
}

String _$monthlyTotalsHash() => r'60cb6736858a3ed83e8cfb780516acab598c3d12';
