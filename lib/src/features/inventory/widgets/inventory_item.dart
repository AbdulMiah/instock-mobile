import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/inventory/screens/item_details_page.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

class InventoryItem extends StatefulWidget {
  const InventoryItem(
      {super.key,
      required this.itemName,
      required this.itemCategory,
      required this.itemSku,
      required this.itemStockNo,
      required this.itemOrdersNo,
      this.itemWarning,
      this.itemImgUrl =
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'});

  final String itemName;
  final String itemCategory;
  final String itemSku;
  final String itemStockNo;
  final String itemOrdersNo;
  final String? itemWarning;
  final String? itemImgUrl;

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  void redirectToItemDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemDetails(
          itemName: widget.itemName,
          itemCategory: widget.itemCategory,
          itemSku: widget.itemSku,
          itemStockNo: widget.itemStockNo,
          itemOrdersNo: widget.itemOrdersNo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Column(
      children: [
        if (widget.itemWarning != null) ...[
          Container(
            decoration: BoxDecoration(
              color: theme.themeData.highlightColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.itemWarning!,
                    textDirection: TextDirection.ltr,
                    style: theme.themeData.textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
        ],
        GestureDetector(
          onTap: () {
            redirectToItemDetails();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                gradient: LinearGradient(colors: [
                  theme.themeData.primaryColorLight,
                  theme.themeData.splashColor
                ], begin: const Alignment(0.3, 0), end: Alignment.centerRight)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 74,
                          width: 74,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: const Image(
                                image: NetworkImage(
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 4),
                            child: Text(
                              widget.itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.themeData.textTheme.headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 4),
                            child: Text(
                              widget.itemSku,
                              style: theme.themeData.textTheme.bodySmall
                                  ?.merge(const TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Container(
                                constraints:
                                    const BoxConstraints(minWidth: 100),
                                decoration: BoxDecoration(
                                  color: theme.themeData.primaryColorLight,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(Icons.inventory, size: 14),
                                      ),
                                      TextSpan(
                                        style: TextStyle(
                                            color: theme
                                                .themeData.primaryColorDark),
                                        text: " ${widget.itemStockNo}",
                                      ),
                                      TextSpan(
                                        style: TextStyle(
                                            color: theme
                                                .themeData.primaryColorDark),
                                        text: " In Stock",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              constraints: const BoxConstraints(minWidth: 100),
                              decoration: BoxDecoration(
                                color: theme.themeData.primaryColorLight,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(Icons.update, size: 14),
                                    ),
                                    TextSpan(
                                        style: TextStyle(
                                            color: theme
                                                .themeData.primaryColorDark),
                                        text: " ${widget.itemOrdersNo}"),
                                    TextSpan(
                                      style: TextStyle(
                                          color:
                                              theme.themeData.primaryColorDark),
                                      text: " Orders",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
