import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:instock_mobile/src/features/inventory/widgets/horizontal_category_list.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_search_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/instock_button.dart';
import 'category_heading.dart';
import 'inventory_item.dart';

class InventoryBuilder extends StatefulWidget {
  const InventoryBuilder(
      {super.key,
      required this.inventoryService,
      required this.theme,
      required this.scrollController});

  final InventoryService inventoryService;
  final CommonTheme theme;
  final ItemScrollController scrollController;

  @override
  State<InventoryBuilder> createState() => _InventoryBuilderState();
}

class _InventoryBuilderState extends State<InventoryBuilder> {
  TextEditingController editingController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  List<Item> items = <Item>[];
  Map<String, int> categories = {};
  List<Item> searchResults = <Item>[];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
    } else {
      setState(() {
        searchResults = items;
      });
    }
  }

  void getCategories() {
    for (Item c in items) {
      if (!categories.containsKey(c.category)) {
        int index = items.indexWhere((item) => item.name == c.name);
        categories[c.category] = index;
      }
    }
  }

  Future<void> fetchData() async {
    final data = await widget.inventoryService.getItems(http.Client());
    setState(() {
      items = data;
      searchResults = items;
      getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.inventoryService.getItems(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null && snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: widget.theme.themeData.splashColor,
              ),
            );
          }
          if (snapshot.hasError || snapshot.error is SocketException) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Internet Connection",
                    style: widget.theme.themeData.textTheme.bodyLarge?.merge(const TextStyle(fontSize: 30)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  Text("Please check your internet connection and try again",
                    style: widget.theme.themeData.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40,),
                  InStockButton(
                    onPressed: () {
                      setState((){});
                    },
                    theme: widget.theme.themeData,
                    colorOption: InStockButton.primary,
                    text: "Try Again",
                    icon: Icons.refresh,
                  ),
                ],
              ),
            );
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

          return Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(12, 50, 12, 8),
                child: InStockSearchBar(
                  text: "Search",
                  hintText: "Search for items",
                  theme: widget.theme.themeData,
                  controller: editingController,
                  onChanged: (value) {
                    filterSearchResults(value!);
                  },
                ),
              ),
              HorizontalCategoryList(
                  scrollController: widget.scrollController,
                  categories: categories
              ),
              Expanded(
                child: Scrollbar(
                  thickness: 5,
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: fetchData,
                    color: widget.theme.themeData.splashColor,
                    child: ScrollablePositionedList.builder(
                        shrinkWrap: true,
                        itemScrollController: widget.scrollController,
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          String? warningMsg;
                          bool isSameCategory = true;
                          int stock = int.parse(searchResults[index].stock);
                          if (stock <= 5) {
                            warningMsg = 'Low Stock';
                          }
                          String category = searchResults[index].category;
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Column(
                                children: [
                                  CategoryHeading(category: category),
                                  InventoryItem(
                                    itemName: searchResults[index].name,
                                    itemCategory: searchResults[index].category,
                                    itemSku: searchResults[index].sku,
                                    itemStockNo: searchResults[index].stock,
                                    itemOrdersNo: 'N/A',
                                    itemWarning: warningMsg,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            String prevCategory = searchResults[index - 1].category;
                            isSameCategory = prevCategory == category;
                          }
                          return isSameCategory == true
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  child: InventoryItem(
                                    itemName: searchResults[index].name,
                                    itemCategory: searchResults[index].category,
                                    itemSku: searchResults[index].sku,
                                    itemStockNo: searchResults[index].stock,
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
                                        itemName: searchResults[index].name,
                                        itemCategory: searchResults[index].category,
                                        itemSku: searchResults[index].sku,
                                        itemStockNo: searchResults[index].stock,
                                        itemOrdersNo: 'N/A',
                                        itemWarning: warningMsg,
                                      ),
                                    ],
                                  ),
                              );
                        }
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
