import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:instock_mobile/src/utililities/widgets/instock_button.dart';

void main() {
  testWidgets('Button runs on press method', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    bool pressed = false;
    testMethod() {
      pressed = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockButton(
          text: 'Test Button',
          onPressed: () {
            testMethod();
          },
          theme: commonTheme.themeData,
          colorOption: InStockButton.accent,
        )),
      ),
    );

    final buttonFinder = find.text('Test Button');

    //When
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    //Then
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(pressed, true);
  });

  testWidgets('Button displays given text', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    bool pressed = false;
    testMethod() {
      pressed = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockButton(
          text: 'Test Button',
          onPressed: () {
            testMethod();
          },
          theme: commonTheme.themeData,
          colorOption: InStockButton.accent,
        )),
      ),
    );

    // When
    final buttonFinder = find.text('Test Button');

    //Then
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets('Button loading is true displays spinner', (tester) async {
    //Given
    CommonTheme commonTheme = CommonTheme();

    bool pressed = false;
    testMethod() {
      pressed = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: InStockButton(
          text: 'Test Button',
          onPressed: () {
            testMethod();
          },
          theme: commonTheme.themeData,
          colorOption: InStockButton.accent,
          isLoading: true,
        )),
      ),
    );

    // When
    final buttonFinder = find.text('Test Button');

    //Then
    expect(buttonFinder, findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
