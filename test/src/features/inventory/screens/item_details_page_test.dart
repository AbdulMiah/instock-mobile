import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/screens/item_details_page.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Page displays correct data', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              itemName: 'Test Name',
              itemSku: 'Test SKU',
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

  testWidgets('Form fields disabled by default', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              itemName: 'Test Name',
              itemSku: 'Test SKU',
              itemStockNo: '33',
              itemOrdersNo: '44',
              itemCategory: 'Test Category',
            ),
          ),
        )));
    const nameKey = Key('itemNameTextField');
    const categoryKey = Key('itemCategoryTextField');
    const skuKey = Key('itemSKUTextField');
    final nameFormField = tester.widget<InStockTextInput>(find.byKey(nameKey));
    final categoryFormField =
        tester.widget<InStockTextInput>(find.byKey(categoryKey));
    final skuFormField = tester.widget<InStockTextInput>(find.byKey(skuKey));

    expect(nameFormField.enable, false);
    expect(categoryFormField.enable, false);
    expect(skuFormField.enable, false);
  });
}
