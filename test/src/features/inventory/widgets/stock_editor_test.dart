import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/inventory/widgets/stock_editor.dart';

void main() {
  testWidgets(
    'Stock editor renders',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockEditor(
              currentStock: 12,
              itemSKU: 'Test-123',
              businessId: 'Test-123',
            ),
          ),
        ),
      );

      final saleFinder = find.text('Sale');
      final restockFinder = find.text('Restock');
      final reasonFinder = find.text('Reason:');
      final add10Finder = find.text('+10');

      expect(saleFinder, findsOneWidget);
      expect(restockFinder, findsOneWidget);
      expect(reasonFinder, findsOneWidget);
      expect(add10Finder, findsOneWidget);
    },
  );

  testWidgets(
    'Stock editor renders correct initial stock amounts',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockEditor(
              currentStock: 12,
              itemSKU: 'Test-123',
              businessId: 'Test-123',
            ),
          ),
        ),
      );

      final stockAmountAndFinalStock = find.text('12');
      final adjustStockFinder = find.text('0');

      expect(stockAmountAndFinalStock, findsNWidgets(2));
      expect(adjustStockFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Stock editor allows stock amounts to be edited',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockEditor(
              currentStock: 12,
              itemSKU: 'Test-123',
              businessId: 'Test-123',
            ),
          ),
        ),
      );

      final add10Button = find.text('+10');

      await tester.tap(add10Button);
      await tester.tap(add10Button);
      await tester.pumpAndSettle();

      final adjustStockFinderUpdated = find.text('20');
      final totalStockAfterUpdate = find.text('32');

      expect(adjustStockFinderUpdated, findsOneWidget);
      expect(totalStockAfterUpdate, findsOneWidget);
    },
  );
}
