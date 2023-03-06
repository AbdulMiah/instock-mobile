import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/screens/item_details_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Page displays correct data', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              itemName: 'Test Name',
              itemSKU: 'Test SKU',
              itemStockNo: '33',
              itemOrdersNo: '44',
              itemCategory: 'Test Category',
            ),
          ),
        )));

    final nameFinder = find.text('Test Name');
    final skuFinder = find.text('Test SKU');
    final categoryFinder = find.text('Test Category');

    expect(nameFinder, findsNWidgets(2));
    expect(skuFinder, findsOneWidget);
    expect(categoryFinder, findsOneWidget);
  });
}
