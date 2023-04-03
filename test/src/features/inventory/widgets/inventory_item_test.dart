// void main() {
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/widgets/inventory_item.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets(
    'Displays Item Details',
    (tester) async {
      Item item = Item(
          category: 'Test',
          sku: 'Test SKU',
          name: 'Test Name',
          businessId: 'WEE-WEE',
          stockAmount: 33,
          ordersAmount: 10,
          itemWarning: '',
          itemImgUrl: '');

      await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: InventoryItem(
                item: item, refreshFunc: () {  },
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
      Item item = Item(
          category: 'Test',
          sku: 'Test SKU',
          name: 'Test Name',
          businessId: 'WEE-WEE',
          stockAmount: 3,
          ordersAmount: 2,
          itemWarning: 'Low Stock',
          itemImgUrl: '');

      await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: InventoryItem(
                item: item, refreshFunc: () {  },
              ),
            ),
          )));

      final warningFinder = find.text('Low Stock');

      expect(warningFinder, findsOneWidget);
    },
  );
}
