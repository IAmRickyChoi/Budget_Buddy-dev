// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 앱 전체에서 DB 연결은 하나만 쓴다(keepAlive).
/// 테스트에서는 이 Provider를 인메모리 DB로 override 한다.

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// 앱 전체에서 DB 연결은 하나만 쓴다(keepAlive).
/// 테스트에서는 이 Provider를 인메모리 DB로 override 한다.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// 앱 전체에서 DB 연결은 하나만 쓴다(keepAlive).
  /// 테스트에서는 이 Provider를 인메모리 DB로 override 한다.
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'a884881a2f0b50f05695b3c3baca8af854a8aa14';
