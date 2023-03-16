// void main() {
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/widgets/inventory_item.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets(
    'Displays Item Details',
    (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(const MaterialApp(
            home: Scaffold(
              body: InventoryItem(
                itemName: 'Test Name',
                itemSku: 'Test SKU',
                itemStockNo: '33',
                itemOrdersNo: '44',
                itemCategory: 'Test Category',
                itemWarning: null,
              ),
            ),
          )));

      final nameFinder = find.text('Test Name');
      final skuFinder = find.text('Test SKU');
      final itemStockNoFinder =
          find.textContaining('33 In Stock', findRichText: true);

      expect(nameFinder, findsOneWidget);
      expect(skuFinder, findsOneWidget);
      expect(itemStockNoFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Displays Low Stock Warning',
    (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(const MaterialApp(
            home: Scaffold(
              body: InventoryItem(
                itemName: 'Test Name',
                itemSku: 'Test SKU',
                itemStockNo: '5',
                itemOrdersNo: '44',
                itemCategory: 'Test Category',
                itemWarning: 'Low Stock',
              ),
            ),
          )));

      final warningFinder = find.text('Low Stock');

      expect(warningFinder, findsOneWidget);
    },
  );
}
