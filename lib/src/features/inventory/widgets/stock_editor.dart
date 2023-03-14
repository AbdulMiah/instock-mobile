import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';
import 'package:instock_mobile/src/utilities/widgets/instock_button.dart';

class StockEditor extends StatefulWidget {
  StockEditor({super.key, required this.currentStock});

  int currentStock;

  @override
  State<StockEditor> createState() => _StockEditorState();
}

class _StockEditorState extends State<StockEditor> {
  int _changeStockAmountBy = 0;
  int _calculatedStockAmount = 0;
  Widget selected = 

  calculateNewStockAmount() {
    int totalStock = widget.currentStock + _changeStockAmountBy;
    setState(() {
      _calculatedStockAmount = totalStock;
    });
  }

  updateChangeStockAmountBy(int changeBy) {
    int newValue = _changeStockAmountBy + changeBy;
    setState(() {
      _changeStockAmountBy = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    calculateNewStockAmount();
    final theme = CommonTheme();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Text(
            "In stock:",
            style: theme.themeData.textTheme.titleMedium,
          ),
          Text('${widget.currentStock}',
              style: theme.themeData.textTheme.headlineMedium),
          Text("${_changeStockAmountBy}",
              style: theme.themeData.textTheme.headlineMedium),
          SizedBox(
            width: 100,
            child: Divider(
              thickness: 1,
              height: 16,
              color: theme.themeData.primaryColorDark,
            ),
          ),
          Text("${_calculatedStockAmount}",
              style: theme.themeData.textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                    child: InStockButton(
                        text: "-10",
                        onPressed: () {
                          print("-10");
                          updateChangeStockAmountBy(-10);
                        },
                        theme: theme.themeData,
                        colorOption: InStockButton.primary),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                    child: InStockButton(
                        text: "-1",
                        onPressed: () {
                          updateChangeStockAmountBy(-1);
                        },
                        theme: theme.themeData,
                        colorOption: InStockButton.primary),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                    child: InStockButton(
                        text: "+1",
                        onPressed: () {
                          print("+1");
                          updateChangeStockAmountBy(1);
                        },
                        theme: theme.themeData,
                        colorOption: InStockButton.secondary),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                    child: InStockButton(
                        text: "+10",
                        onPressed: () {
                          print("+10");
                          updateChangeStockAmountBy(10);
                        },
                        theme: theme.themeData,
                        colorOption: InStockButton.secondary),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
            child:
                Text("Reason:", style: theme.themeData.textTheme.titleMedium),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                  child: InStockButton(
                      text: "Sale",
                      onPressed: () {
                        print("Sale");
                      },
                      theme: theme.themeData,
                      colorOption: InStockButton.accent),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                  child: InStockButton(
                      text: "ReStock",
                      onPressed: () {
                        print("ReStock");
                      },
                      theme: theme.themeData,
                      colorOption: InStockButton.primary),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                  child: InStockButton(
                      text: "Correction",
                      onPressed: () {
                        print("Correction");
                      },
                      theme: theme.themeData,
                      colorOption: InStockButton.primary),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                  child: InStockButton(
                      text: "Damaged",
                      onPressed: () {
                        print("Damaged");
                      },
                      theme: theme.themeData,
                      colorOption: InStockButton.primary),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.themeData.cardColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: null,
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                  animationDuration: Duration(milliseconds: 150),
                  hasIcon: true,
                  tapHeaderToExpand: true),
              header: Container(
                alignment: Alignment.center,
                child: Text(
                  "More Options",
                  style: theme.themeData.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              collapsed: Container(),
              expanded: Expanded(
                child: Container(
                  color: theme.themeData.cardColor,
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                              child: InStockButton(
                                  text: "Sale",
                                  onPressed: () {
                                    print("Sale");
                                  },
                                  theme: theme.themeData,
                                  colorOption: InStockButton.accent),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                              child: InStockButton(
                                  text: "ReStock",
                                  onPressed: () {
                                    print("ReStock");
                                  },
                                  theme: theme.themeData,
                                  colorOption: InStockButton.primary),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                              child: InStockButton(
                                  text: "Correction",
                                  onPressed: () {
                                    print("Correction");
                                  },
                                  theme: theme.themeData,
                                  colorOption: InStockButton.primary),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                              child: InStockButton(
                                  text: "Damaged",
                                  onPressed: () {
                                    print("Damaged");
                                  },
                                  theme: theme.themeData,
                                  colorOption: InStockButton.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
