import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('starts on the transactions tab', (tester) async {
    await pumpApp(tester);

    expect(find.widgetWithText(AppBar, 'Transactions'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('switches tabs from the bottom bar', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Budgets'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Budgets'), findsOneWidget);
    await disposeApp(tester);
  });

  testWidgets('FAB opens the add transaction screen', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Add transaction'), findsOneWidget);
    expect(find.byType(BottomAppBar), findsNothing);
    await disposeApp(tester);
  });

  testWidgets('follows the device language', (tester) async {
    await pumpApp(tester, locale: const Locale('ko', 'KR'));

    expect(find.widgetWithText(AppBar, '내역'), findsOneWidget);
    expect(find.text('설정'), findsOneWidget);
    await disposeApp(tester);
  });
}
