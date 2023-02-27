import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/category_heading.dart';

void main() {
  testWidgets('Displays Category', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CategoryHeading(category: 'Test Category'),
        ),
      ),
    );
    final categoryFinder = find.text('Test Category');

    expect(categoryFinder, findsOneWidget);
  });
}
