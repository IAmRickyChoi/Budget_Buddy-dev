// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 라우터를 Provider로 두면 나중에 로그인 상태(authProvider)를 watch해서
/// 로그인 전이면 로그인 화면으로 보내는 redirect를 한 곳에서 처리할 수 있다.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// 라우터를 Provider로 두면 나중에 로그인 상태(authProvider)를 watch해서
/// 로그인 전이면 로그인 화면으로 보내는 redirect를 한 곳에서 처리할 수 있다.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// 라우터를 Provider로 두면 나중에 로그인 상태(authProvider)를 watch해서
  /// 로그인 전이면 로그인 화면으로 보내는 redirect를 한 곳에서 처리할 수 있다.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'cac9d0a102f181af98fd9ab1a7a5911418c38995';
