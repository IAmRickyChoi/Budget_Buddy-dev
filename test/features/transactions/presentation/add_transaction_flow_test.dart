import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('adding an expense shows it in the list and the totals', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(find.text('No transactions this month'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('amountField')), '12.5');
    await tester.tap(find.text('Food'));
    await tester.enterText(find.widgetWithText(TextField, 'Note'), 'Lunch');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // 저장 후 목록 화면으로 돌아와 있고, 새 거래가 보인다.
    expect(find.widgetWithText(AppBar, 'Transactions'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Lunch'), findsOneWidget);
    expect(find.widgetWithText(ListTile, r'-$12.50'), findsOneWidget);
    // 월 합계: 지출 $12.50, 합계 -$12.50
    expect(find.text(r'$12.50'), findsOneWidget);
    expect(find.text(r'-$12.50'), findsNWidgets(2));
    await disposeApp(tester);
  });

  testWidgets('shows an error instead of saving an invalid amount', (
    tester,
  ) async {
    await pumpApp(tester, currencyCode: 'KRW');

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid amount'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Add transaction'), findsOneWidget);
    await disposeApp(tester);
  });
}
