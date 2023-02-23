import 'package:flutter/material.dart';

class InventoryItem extends StatefulWidget {
  const InventoryItem({required this.theme});

  final ThemeData theme;

  @override
  State<InventoryItem> createState() => _InventoryItemState();
}

class _InventoryItemState extends State<InventoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.theme.highlightColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: const Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Low stock or material status 1234',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.white, Colors.green],
            begin: Alignment(0.4, 0.4),
            end: Alignment(1, 1),
          )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: widget.theme.highlightColor,
                        ),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 0, 8),
                        child: Text(
                          'Item Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 0, 4),
                        child: Text(
                          'Item SKU',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 1, 4, 8),
                        child: Container(
                          constraints: BoxConstraints(minWidth: 90),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.inventory, size: 14),
                                ),
                                TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: " X In Stock",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: 90),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.update, size: 14),
                              ),
                              TextSpan(
                                style: TextStyle(color: Colors.black),
                                text: " X Orders",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
