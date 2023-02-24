import 'package:flutter/material.dart';

import 'inventory_item.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                children: <Widget>[
                  Text("Inventory"),
                  InventoryItem(
                    theme: theme,
                    itemName: "Birthday Cockatoo",
                    itemSKU: "SKU",
                    itemStockNo: "406",
                    itemOrdersNo: "4",
                    // itemWarning: "Low stock",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
