import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:instock_mobile/src/utilities/widgets/back_button.dart';

void main() {
  testWidgets('Back Button renders', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InStockBackButton(
            page: Welcome(),
            colorOption: InStockBackButton.primary,
          ),
        ),
      ),
    );

    //When
    final iconFinder = find.byIcon(Icons.arrow_back);

    //Then
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Back Button can redirect to page on tap', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InStockBackButton(
            page: Welcome(),
            colorOption: InStockBackButton.primary,
          ),
        ),
      ),
    );

    final iconFinder = find.byIcon(Icons.arrow_back);

    //When
    await tester.tap(iconFinder);
    await tester.pumpAndSettle();

    //Then
    final welcomeFinder = find.text('Welcome To InStock');
    expect(welcomeFinder, findsOneWidget);
  });
}
