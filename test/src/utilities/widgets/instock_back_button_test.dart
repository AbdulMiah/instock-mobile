import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/authentication/screens/welcome_page.dart';
import 'package:instock_mobile/src/utilities/widgets/back_button.dart';

void main() {
  testWidgets('Back Button renders', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
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

  testWidgets('Back Button can redirect to previous page on tap', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Welcome()),
      ),
    );

    final loginFinder = find.text('Login');
    await tester.tap(loginFinder);
    await tester.pumpAndSettle();

    //When
    final iconFinder = find.byIcon(Icons.arrow_back);
    await tester.tap(iconFinder);
    await tester.pumpAndSettle();

    //Then
    final welcomeFinder = find.text('Welcome To InStock');
    expect(welcomeFinder, findsOneWidget);
  });
}
