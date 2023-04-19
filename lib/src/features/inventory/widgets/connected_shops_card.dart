import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/common_theme.dart';
import '../data/connected_item_dto.dart';
import 'connected_item_card.dart';

class ConnectedShopsCard extends StatefulWidget {
  const ConnectedShopsCard(
      {Key? key, required this.theme, required this.connectedItem})
      : super(key: key);

  final CommonTheme theme;
  final ConnectedItemDto connectedItem;

  @override
  State<ConnectedShopsCard> createState() => _ConnectedShopsCardState();
}

class _ConnectedShopsCardState extends State<ConnectedShopsCard> {
  String getLastUpdated(String dateTimeString) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    String lastUpdated = dateFormat.format(dateTime);
    return lastUpdated;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.theme.themeData.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Last Updated: ${getLastUpdated(widget.connectedItem.lastUpdated!)}",
              style: widget.theme.themeData.textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: widget.connectedItem.platformImageUrl != null
                        ? Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                widget.connectedItem.platformImageUrl!),
                          )
                        : const Icon(Icons.image),
                  ),
                ),
                const VerticalDivider(
                  width: 10,
                ),
                Text(
                  "${widget.connectedItem.shopName}",
                  style: widget.theme.themeData.textTheme.labelMedium,
                ),
              ],
            ),
            ConnectedItemSaleStockOrderView(
              theme: widget.theme,
              totalStock: widget.connectedItem.totalStock!,
              availableStock: widget.connectedItem.availableStock!,
              totalOrders: widget.connectedItem.totalOrders!,
            ),
          ],
        ));
  }
}
