import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/business/services/business_service.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:instock_mobile/src/features/inventory/widgets/horizontal_category_list.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_search_bar.dart';
import 'package:instock_mobile/src/utilities/widgets/no_internet_page.dart';
import 'package:instock_mobile/src/utilities/widgets/page_route_animation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/loading_spinner.dart';
import '../../business/screens/add_business_page.dart';
import 'category_heading.dart';
import 'inventory_item.dart';

class InventoryBuilder extends StatefulWidget {
  const InventoryBuilder(
      {super.key, required this.inventoryService, required this.theme});

  final InventoryService inventoryService;
  final CommonTheme theme;

  @override
  State<InventoryBuilder> createState() => _InventoryBuilderState();
}

class _InventoryBuilderState extends State<InventoryBuilder> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  TextEditingController editingController = TextEditingController();
  ItemScrollController itemScrollController = ItemScrollController();

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
      final suggestions = items.where((item) {
        final name = item.name.toLowerCase();
        final sku = item.sku.toLowerCase();
        final category = item.category.toLowerCase();
        final input = query.toLowerCase();

        return name.contains(input) ||
            sku.contains(input) ||
            category.contains(input);
      }).toList();
      setState(() {
        searchResults = suggestions;
        getCategories();
      });
    } else {
      setState(() {
        searchResults = items;
        getCategories();
      });
    }
  }

  void getCategories() {
    categories.clear();
    for (Item c in searchResults) {
      if (!categories.containsKey(c.category)) {
        int index = searchResults.indexWhere((item) => item.name == c.name);
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

  checkBusinessExists() async {
    BusinessService businessService = BusinessService();
    bool doesBusinessExist = await businessService.doesBusinessExist();

    if (!doesBusinessExist) {
      // Go to Add Business page if user has no business
      Navigator.pushAndRemoveUntil<void>(
        context,
        PageRouteAnimation(page: const AddBusiness()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.inventoryService.getItems(http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          checkBusinessExists();
          if (snapshot.data == null &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LoadingSpinner(),
            );
          }
          if (snapshot.error is SocketException) {
            return NoInternetPage(refreshFunc: fetchData);
          }
          if (snapshot.error is Exception) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                    child: Text(
                      "Looks like you have no items in your inventory... \n\nGo to 'Add Item' to get started!",
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
                  onClear: () {
                    editingController.text = "";
                    filterSearchResults(editingController.text);
                  },
                ),
              ),
              HorizontalCategoryList(
                  scrollController: itemScrollController,
                  categories: categories),
              editingController.text.isNotEmpty && searchResults.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          const Icon(Icons.search_off),
                          Text(
                            "No items found for '${editingController.text}'",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                          thumbColor: MaterialStateProperty.all(widget
                              .theme.themeData.primaryColorDark
                              .withOpacity(0.5)),
                          radius: const Radius.circular(20),
                        )),
                        child: Scrollbar(
                          thickness: 5,
                          child: RefreshIndicator(
                            key: _refreshIndicatorKey,
                            onRefresh: fetchData,
                            color: widget.theme.themeData.splashColor,
                            child: ScrollablePositionedList.builder(
                                shrinkWrap: true,
                                itemScrollController: itemScrollController,
                                itemCount: searchResults.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Item item = Item(
                                    sku: searchResults[index].sku,
                                    businessId: searchResults[index].businessId,
                                    category: searchResults[index].category,
                                    name: searchResults[index].name,
                                    stockAmount:
                                        searchResults[index].stockAmount,
                                    totalOrders:
                                        searchResults[index].totalOrders,
                                    itemWarning: null,
                                    itemImgUrl: searchResults[index].itemImgUrl,
                                    totalStock: searchResults[index].totalStock,
                                    availableStock:
                                        searchResults[index].availableStock,
                                  );
                                  bool isSameCategory = true;
                                  int stock = item.stockAmount;
                                  if (stock <= 5) {
                                    item.itemWarning =
                                        'Low Stock: Below 5 Items';
                                  }
                                  String category =
                                      searchResults[index].category;
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 8, 12, 8),
                                      child: Column(
                                        children: [
                                          CategoryHeading(category: category),
                                          InventoryItem(
                                            item: item,
                                            refreshFunc: fetchData,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    String prevCategory =
                                        searchResults[index - 1].category;
                                    isSameCategory = prevCategory == category;
                                  }
                                  return isSameCategory == true
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 12, 8),
                                          child: InventoryItem(
                                            item: item,
                                            refreshFunc: fetchData,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 8, 12, 8),
                                          child: Column(
                                            children: [
                                              CategoryHeading(
                                                  category: category),
                                              InventoryItem(
                                                item: item,
                                                refreshFunc: fetchData,
                                              ),
                                            ],
                                          ),
                                        );
                                }),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        });
  }
}
