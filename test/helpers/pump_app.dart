import 'package:budget_buddy/app/app.dart';
import 'package:budget_buddy/core/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_database.dart';

/// 실제 기기 DB 대신 인메모리 DB를 끼워서 앱 전체를 띄운다.
Future<void> pumpApp(
  WidgetTester tester, {
  Locale locale = const Locale('en', 'US'),
  String currencyCode = 'USD',
}) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);

  final db = createTestDatabase(currencyCode: currencyCode);
  addTearDown(db.close);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const App(),
    ),
  );
  await tester.pumpAndSettle();
}

/// Drift 스트림이 정리될 때 쓰는 타이머를 테스트 끝나기 전에 흘려보낸다.
Future<void> disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 1));
}
