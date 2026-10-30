import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plot_their_future/main.dart';
import 'package:plot_their_future/screens/security_faq_screen.dart';
import 'package:plot_their_future/widgets/gift_sqft_sheet.dart';

void main() {
  testWidgets('App loads and renders title test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PlotTheirFutureApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Plot Their Future'), findsWidgets);
  });

  testWidgets('App renders on narrow 320px screen without AppBar overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: PlotTheirFutureApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Plot Their Future'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('SecurityFaqScreen renders on narrow screen without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(340, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SecurityFaqScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('WHAT HAPPENS TO YOUR MONEY?'), findsOneWidget);
    expect(find.text('1. Guest UPI'), findsOneWidget);
    expect(find.text('2. Bank Escrow'), findsOneWidget);
    expect(find.text('3. RERA Builder'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('GiftSqFtSheet bottom total bar renders without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(340, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: GiftSqFtSheet(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('TOTAL FOUNDATION GIFT'), findsOneWidget);
    expect(find.text('Gift & Mint Deed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
