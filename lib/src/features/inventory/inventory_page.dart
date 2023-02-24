import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/inventory/inventory_item.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    var inventoryService = InventoryService();
    final theme = Theme.of(context);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: 300,
            child: FutureBuilder(
                future: inventoryService.getItems(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(child: Text("Loading")),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: InventoryItem(
                              theme: theme,
                              itemName: snapshot.data[index].name,
                              itemSKU: snapshot.data[index].SKU,
                              itemStockNo: snapshot.data[index].stock,
                              itemOrdersNo: "N/A"),
                        );
                      });
                }),
          ),
        )),
      ),
    );
  }
}
