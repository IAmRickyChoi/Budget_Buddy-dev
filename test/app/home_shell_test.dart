import 'package:budget_buddy/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, Locale locale) async {
    tester.platformDispatcher.localesTestValue = [locale];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
  }

  testWidgets('starts on the transactions tab', (tester) async {
    await pumpApp(tester, const Locale('en'));

    expect(find.widgetWithText(AppBar, 'Transactions'), findsOneWidget);
  });

  testWidgets('switches tabs from the bottom bar', (tester) async {
    await pumpApp(tester, const Locale('en'));

    await tester.tap(find.text('Budgets'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Budgets'), findsOneWidget);
  });

  testWidgets('FAB opens the add transaction screen', (tester) async {
    await pumpApp(tester, const Locale('en'));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Add transaction'), findsOneWidget);
    expect(find.byType(BottomAppBar), findsNothing);
  });

  testWidgets('follows the device language', (tester) async {
    await pumpApp(tester, const Locale('ko'));

    expect(find.widgetWithText(AppBar, '내역'), findsOneWidget);
    expect(find.text('설정'), findsOneWidget);
  });
}
