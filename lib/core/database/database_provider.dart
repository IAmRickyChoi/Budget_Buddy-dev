import 'dart:ui';

import 'package:budget_buddy/core/database/app_database.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

/// 앱 전체에서 DB 연결은 하나만 쓴다(keepAlive).
/// 테스트에서는 이 Provider를 인메모리 DB로 override 한다.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase(defaultCurrencyCode: _deviceCurrencyCode());
  ref.onDispose(db.close);
  return db;
}

/// 기기 지역 설정으로 기본 통화를 고른다. (ko_KR → KRW, ja_JP → JPY)
String _deviceCurrencyCode() {
  try {
    final locale = PlatformDispatcher.instance.locale.toString();
    return NumberFormat.simpleCurrency(locale: locale).currencyName ?? 'USD';
  } on Object {
    return 'USD';
  }
}
