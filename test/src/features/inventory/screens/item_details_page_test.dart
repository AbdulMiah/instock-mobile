import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/screens/item_details_page.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_text_input.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Item item = Item(
    category: 'Test Category',
    sku: 'Test SKU',
    name: 'Test Name',
    businessId: 'WEE-WEE',
    stockAmount: 33,
    itemWarning: '',
    itemImgUrl: '',
    totalStock: 30,
    totalOrders: 10,
    availableStock: 20,
  );

  testWidgets('Page displays correct data', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              item: item,
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
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              item: item,
            ),
          ),
        )));
    const nameKey = Key('itemNameTextField');
    const categoryKey = Key('itemCategoryTextField');
    const skuKey = Key('itemSkuTextField');
    final nameFormField = tester.widget<InStockTextInput>(find.byKey(nameKey));
    final categoryFormField =
        tester.widget<InStockTextInput>(find.byKey(categoryKey));
    final skuFormField = tester.widget<InStockTextInput>(find.byKey(skuKey));

    expect(nameFormField.enable, false);
    expect(categoryFormField.enable, false);
    expect(skuFormField.enable, false);
  });

  testWidgets('Delete button present', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              item: item,
            ),
          ),
        )));

    final deleteFinder = find.text("Delete");

    expect(deleteFinder, findsOneWidget);
  });

  testWidgets('Delete button on click pulls up confirm', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              item: item,
            ),
          ),
        )));

    const deleteButtonKey = Key('DeleteItemButton');
    final deleteFinder = find.byKey(deleteButtonKey);

    // Scrolls till deleteFinder is visible
    await tester.ensureVisible(deleteFinder);

    await tester.tap(deleteFinder);
    await tester.pumpAndSettle();

    final dialogFinder = find.byType(AlertDialog);
    expect(dialogFinder, findsOneWidget);
  });

  testWidgets('Cancel button on alert dialog hides dialog', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ItemDetails(
              item: item,
            ),
          ),
        )));

    const deleteButtonKey = Key('DeleteItemButton');
    final deleteFinder = find.byKey(deleteButtonKey);

    // Scrolls till deleteFinder is visible
    await tester.ensureVisible(deleteFinder);

    await tester.tap(deleteFinder);
    await tester.pumpAndSettle();

    final cancelFinder = find.text("Cancel");
    await tester.tap(cancelFinder);
    await tester.pumpAndSettle();

    final dialogFinder = find.byType(AlertDialog);
    expect(dialogFinder, findsNothing);
  });
}
