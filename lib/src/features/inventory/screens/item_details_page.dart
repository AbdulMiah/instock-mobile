import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/screens/inventory_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/wave.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails(
      {super.key,
      required this.itemName,
      required this.itemSKU,
      required this.itemStockNo,
      required this.itemOrdersNo,
      this.itemWarning});

  final String itemName;
  final String itemSKU;
  final String itemStockNo;
  final String itemOrdersNo;
  final String? itemWarning;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    return MaterialApp(
      home: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: theme.themeData.splashColor),
          child: SafeArea(
              child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Container(
                            color: theme.themeData.splashColor,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                widget.itemName,
                                style: theme.themeData.textTheme.bodyMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(top: 10, right: 10, child: Icon(Icons.edit)),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: InStockBackButton(
                              page: const Inventory(),
                              colorOption: InStockBackButton.secondary,
                            )),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05 - 2,
                          child: InStockWave(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
