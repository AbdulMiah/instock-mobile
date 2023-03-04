import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:instock_mobile/src/features/inventory/widgets/category_heading.dart';
import 'package:instock_mobile/src/features/inventory/widgets/inventory_item.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/wave.dart';

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
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: theme.themeData.splashColor),
          child: SafeArea(
              child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Container(
                            color: theme.themeData.splashColor,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                "Inventory",
                                style: theme.themeData.textTheme.headlineMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: FutureBuilder(
                              future: inventoryService.getItems(http.Client()),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    // backgroundColor: theme.themeData.splashColor,
                                    color: theme.themeData.splashColor,
                                  ));
                                }
                                if (snapshot.data.length == 0) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      child: Text(
                                        "You don't have any items yet, add some to get started",
                                        style: theme
                                            .themeData.textTheme.bodyLarge
                                            ?.merge(
                                                const TextStyle(fontSize: 30)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool isSameCategory = true;
                                      String category =
                                          snapshot.data[index].category;
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 12, 8),
                                          child: Column(
                                            children: [
                                              CategoryHeading(
                                                  category: category),
                                              InventoryItem(
                                                  itemName:
                                                      snapshot.data[index].name,
                                                  itemSKU:
                                                      snapshot.data[index].SKU,
                                                  itemStockNo: snapshot
                                                      .data[index].stock,
                                                  itemOrdersNo: "N/A"),
                                            ],
                                          ),
                                        );
                                      } else {
                                        String prevCategory =
                                            snapshot.data[index - 1].category;
                                        isSameCategory =
                                            prevCategory == category;
                                      }
                                      if (isSameCategory == true) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 12, 8),
                                          child: InventoryItem(
                                              itemName:
                                                  snapshot.data[index].name,
                                              itemSKU: snapshot.data[index].SKU,
                                              itemStockNo:
                                                  snapshot.data[index].stock,
                                              itemOrdersNo: "N/A"),
                                        );
                                      } else if (isSameCategory == false) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 12, 8),
                                          child: Column(
                                            children: [
                                              CategoryHeading(
                                                  category: category),
                                              InventoryItem(
                                                  itemName:
                                                      snapshot.data[index].name,
                                                  itemSKU:
                                                      snapshot.data[index].SKU,
                                                  itemStockNo: snapshot
                                                      .data[index].stock,
                                                  itemOrdersNo: "N/A"),
                                            ],
                                          ),
                                        );
                                      }
                                    });
                              }),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05 - 2,
                          child: InStockWave(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
