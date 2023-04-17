import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

class SaleStockOrderView extends StatefulWidget {
  const SaleStockOrderView(
      {Key? key,
        required this.theme,
        this.totalSales,
        required this.totalStock,
        required this.availableStock,
        required this.totalOrders})
      : super(key: key);

  final CommonTheme theme;
  final int? totalSales;
  final int totalStock;
  final int availableStock;
  final int totalOrders;

  @override
  State<SaleStockOrderView> createState() => _SaleStockOrderViewState();
}

class _SaleStockOrderViewState extends State<SaleStockOrderView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          widget.totalSales == null
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: widget.theme.themeData.cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    "Total Sales: ${widget.totalSales}",
                    style: widget.theme.themeData.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Total\nStock',
                      style: widget.theme.themeData.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Text("${widget.totalStock}",
                      style: widget.theme.themeData.textTheme.bodySmall),
                ],
              ),
              SizedBox(
                height: 70,
                child: VerticalDivider(
                  width: 20,
                  thickness: 1,
                  color: widget.theme.themeData.primaryColorDark,
                ),
              ),
              Column(
                children: [
                  Text('Available\nStock',
                      style: widget.theme.themeData.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Text("${widget.availableStock}",
                      style: widget.theme.themeData.textTheme.bodySmall),
                ],
              ),
              SizedBox(
                height: 70,
                child: VerticalDivider(
                  width: 20,
                  thickness: 1,
                  color: widget.theme.themeData.primaryColorDark,
                ),
              ),
              Column(
                children: [
                  Text('Total\nOrders',
                      style: widget.theme.themeData.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Text("${widget.totalOrders}",
                      style: widget.theme.themeData.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ]
    );
  }
}
