import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/category_heading.dart';
import 'package:instock_mobile/src/features/inventory/inventory_item.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';

import '../../theme/common_theme.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    var inventoryService = InventoryService();

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              const Text("Inventory"),
              FutureBuilder(
                  future: inventoryService.getItems(http.Client()),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                          child: CircularProgressIndicator(
                        // backgroundColor: theme.themeData.splashColor,
                        color: theme.themeData.splashColor,
                      ));
                    }
                    return Flexible(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            bool isSameCategory = true;
                            String category = snapshot.data[index].category;
                            if (index == 0) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child: Column(
                                  children: [
                                    CategoryHeading(category: category),
                                    InventoryItem(
                                        itemName: snapshot.data[index].name,
                                        itemSKU: snapshot.data[index].SKU,
                                        itemStockNo: snapshot.data[index].stock,
                                        itemOrdersNo: "N/A"),
                                  ],
                                ),
                              );
                            } else {
                              String prevCategory =
                                  snapshot.data[index - 1].category;
                              isSameCategory = prevCategory == category;
                            }
                            if (isSameCategory == true) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child: InventoryItem(
                                    itemName: snapshot.data[index].name,
                                    itemSKU: snapshot.data[index].SKU,
                                    itemStockNo: snapshot.data[index].stock,
                                    itemOrdersNo: "N/A"),
                              );
                            } else if (isSameCategory == false) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                child: Column(
                                  children: [
                                    CategoryHeading(category: category),
                                    InventoryItem(
                                        itemName: snapshot.data[index].name,
                                        itemSKU: snapshot.data[index].SKU,
                                        itemStockNo: snapshot.data[index].stock,
                                        itemOrdersNo: "N/A"),
                                  ],
                                ),
                              );
                            }
                          }),
                    );
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
