import 'package:flutter/material.dart';

class InventoryItem extends StatefulWidget {
  const InventoryItem(
      {super.key,
      required this.theme,
      required this.itemName,
      required this.itemSKU,
      required this.itemStockNo,
      required this.itemOrdersNo,
      this.itemWarning});

  final ThemeData theme;
  final String itemName;
  final String itemSKU;
  final String itemStockNo;
  final String itemOrdersNo;
  final itemWarning;

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.itemWarning != null) ...[
          Container(
            decoration: BoxDecoration(
              color: widget.theme.highlightColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.itemWarning,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.green],
                  begin: Alignment(0.3, 0),
                  end: Alignment.centerRight)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 74,
                        width: 74,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                              image: NetworkImage(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8),
                        child: Text(
                          widget.itemName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 4),
                        child: Text(
                          widget.itemSKU,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
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
                              constraints: const BoxConstraints(minWidth: 90),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                      text: " " + widget.itemStockNo,
                                    ),
                                    const TextSpan(
                                      style: TextStyle(color: Colors.black),
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
                            constraints: const BoxConstraints(minWidth: 90),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.update, size: 14),
                                  ),
                                  TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      text: " " + widget.itemOrdersNo),
                                  TextSpan(
                                    style: TextStyle(color: Colors.black),
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
    );
  }
}
