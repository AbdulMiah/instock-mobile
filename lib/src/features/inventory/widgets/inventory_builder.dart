import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:instock_mobile/src/features/inventory/widgets/horizontal_category_list.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_search_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../theme/common_theme.dart';
import 'category_heading.dart';
import 'inventory_item.dart';

class InventoryBuilder extends StatefulWidget {
  const InventoryBuilder(
      {super.key,
      required this.inventoryService,
      required this.theme,
      required this.editingController,
      required this.scrollController});

  final InventoryService inventoryService;
  final CommonTheme theme;
  final TextEditingController editingController;
  final ItemScrollController scrollController;

  @override
  State<InventoryBuilder> createState() => _InventoryBuilderState();
}

class _InventoryBuilderState extends State<InventoryBuilder> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = <Item>[];
    List<Item> searchResults = items;

    void filterSearchResults(String query) {
      if (query.isNotEmpty) {
        setState(() {
          searchResults = items.where((item) {
            final itemName = item.name.toLowerCase();
            final input = query.toLowerCase();

            if (itemName.contains(input)) {
              print(itemName);
            }
            return itemName.contains(input);
          }).toList();
        });
        // setState(() => items = suggestions);
      } else {
        setState(() {
          searchResults = items;
        });
      }
    }

    return FutureBuilder(
        future: widget.inventoryService.getItems(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              color: widget.theme.themeData.splashColor,
            ));
          }
          if (snapshot.data.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                    child: Text(
                      "You don't have any items yet, go to Add Item to get started",
                      style: widget.theme.themeData.textTheme.bodyLarge
                          ?.merge(const TextStyle(fontSize: 20)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }
          items.addAll(snapshot.data);

          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(12, 50, 12, 8),
                child: InStockSearchBar(
                  text: "Search",
                  hintText: "Search for items",
                  theme: widget.theme.themeData,
                  controller: widget.editingController,
                  onChanged: (value) {
                    filterSearchResults(value!);
                  },
                ),
              ),
              Expanded(
                child: ScrollablePositionedList.builder(
                    shrinkWrap: true,
                    itemScrollController: widget.scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      String? warningMsg;
                      bool isSameCategory = true;
                      int stock = int.parse(snapshot.data[index].stock);
                      if (stock <= 5) {
                        warningMsg = 'Low Stock';
                      }
                      String category = snapshot.data[index].category;
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Column(
                            children: [
                              CategoryHeading(category: category),
                              InventoryItem(
                                itemName: snapshot.data[index].name,
                                itemCategory: snapshot.data[index].category,
                                itemSku: snapshot.data[index].sku,
                                itemStockNo: snapshot.data[index].stock,
                                itemOrdersNo: 'N/A',
                                itemWarning: warningMsg,
                              ),
                            ],
                          ),
                        );
                      } else {
                        String prevCategory = snapshot.data[index - 1].category;
                        isSameCategory = prevCategory == category;
                      }
                      return isSameCategory == true
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: InventoryItem(
                                itemName: snapshot.data[index].name,
                                itemCategory: snapshot.data[index].category,
                                itemSku: snapshot.data[index].sku,
                                itemStockNo: snapshot.data[index].stock,
                                itemOrdersNo: "N/A",
                                itemWarning: warningMsg,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Column(
                                children: [
                                  CategoryHeading(category: category),
                                  InventoryItem(
                                    itemName: snapshot.data[index].name,
                                    itemCategory: snapshot.data[index].category,
                                    itemSku: snapshot.data[index].sku,
                                    itemStockNo: snapshot.data[index].stock,
                                    itemOrdersNo: 'N/A',
                                    itemWarning: warningMsg,
                                  ),
                                ],
                              ),
                            );
                    }),
              ),
            ],
          );
        });
  }
}
