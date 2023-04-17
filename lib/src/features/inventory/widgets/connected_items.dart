import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/inventory/widgets/connected_shops_card.dart';

import '../../../theme/common_theme.dart';
import '../data/connected_item_dto.dart';

class ConnectedItems extends StatefulWidget {
  const ConnectedItems({
    Key? key,
    required this.theme,
    required this.totalSales,
    required this.totalStock,
    required this.availableStock,
    required this.totalOrders,
    required this.connectedItems
  })
  : super(key: key);

  final CommonTheme theme;
  final int totalSales;
  final int totalStock;
  final int availableStock;
  final int totalOrders;
  final List<ConnectedItemDto> connectedItems;

  @override
  State<ConnectedItems> createState() => _ConnectedItemsState();
}

class _ConnectedItemsState extends State<ConnectedItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "Connected Items",
          style: widget.theme.themeData.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),

        widget.connectedItems.isNotEmpty
          ? ConnectedShopsCard(connectedItems: widget.connectedItems,)
          : Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.theme.themeData.cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                "This item is not connected. Make sure the SKUs match to link the item to a shop.",
                style: widget.theme.themeData.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
          ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
