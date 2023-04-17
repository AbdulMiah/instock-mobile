import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

class UpdateStockView extends StatefulWidget {
  const UpdateStockView(
      {Key? key,
      required this.theme,
      required this.currentStock,
      required this.changeStockAmountBy,
      required this.calculatedStockAmount})
      : super(key: key);

  final CommonTheme theme;
  final int currentStock;
  final int changeStockAmountBy;
  final int calculatedStockAmount;

  @override
  State<UpdateStockView> createState() => _UpdateStockViewState();
}

class _UpdateStockViewState extends State<UpdateStockView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.theme.themeData.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(children: <Widget>[
          Text(
            "Update Stock",
            style: widget.theme.themeData.textTheme.titleMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Current',
                      style: widget.theme.themeData.textTheme.bodySmall),
                  const Divider(
                    height: 10,
                  ),
                  Text("${widget.currentStock}",
                      style: widget.theme.themeData.textTheme.bodySmall),
                ],
              ),
              const Icon(Icons.keyboard_arrow_right),
              Column(
                children: [
                  Text('Change',
                      style: widget.theme.themeData.textTheme.bodySmall),
                  const Divider(
                    height: 10,
                  ),
                  Text("${widget.changeStockAmountBy}",
                      style: widget.theme.themeData.textTheme.titleMedium),
                ],
              ),
              const Icon(Icons.keyboard_arrow_right),
              Column(
                children: [
                  Text('New',
                      style: widget.theme.themeData.textTheme.bodySmall),
                  const Divider(
                    height: 10,
                  ),
                  Text("${widget.calculatedStockAmount}",
                      style: widget.theme.themeData.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ])
    );
  }
}
