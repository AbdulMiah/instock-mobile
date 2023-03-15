import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/screens/add_item_page.dart';

void main() {
  testWidgets('Page has correct heading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AddItem()),
      ),
    );

    final headingFinder = find.text('Add Item');

    expect(headingFinder, findsNWidgets(2));
  });

  testWidgets('Add item screen renders correct form field', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AddItem()),
      ),
    );

    //When
    final nameFinder = find.text('Name');
    final categoryFinder = find.text('Category');
    final stockLvlFinder = find.text('Stock Level');
    final skuFinder = find.text('SKU Number');

    //Then
    expect(nameFinder, findsOneWidget);
    expect(categoryFinder, findsOneWidget);
    expect(stockLvlFinder, findsOneWidget);
    expect(skuFinder, findsOneWidget);
  });
}
