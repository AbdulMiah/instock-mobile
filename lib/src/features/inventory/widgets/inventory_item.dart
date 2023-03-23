import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:instock_mobile/src/features/inventory/screens/item_details_page.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

class InventoryItem extends StatefulWidget {
  const InventoryItem({super.key, required this.item});

  final Item item;

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  void redirectToItemDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemDetails(
          item: widget.item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return GestureDetector(
      onTap: () {
        redirectToItemDetails();
      },
      child: Column(
        children: [
          if (widget.item.itemWarning != null) ...[
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
                      widget.item.itemWarning!,
                      textDirection: TextDirection.ltr,
                      style: theme.themeData.textTheme.bodySmall?.merge(
                          TextStyle(color: theme.themeData.primaryColorLight)),
                    ),
                  ),
                ),
              ),
            ),
          ],
          Container(
            decoration: BoxDecoration(
                borderRadius: widget.item.itemWarning != null
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      )
                    : const BorderRadius.all(Radius.circular(8)),
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
                            borderRadius: widget.item.itemWarning != null
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(8),
                                  )
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(8),
                                  ),
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
                              widget.item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.themeData.textTheme.headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 4),
                            child: Text(
                              widget.item.sku,
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
                                        text: " ${widget.item.stockAmount}",
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
                                        text: " ${widget.item.ordersAmount}"),
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
          )
        ],
      ),
    );
  }
}
