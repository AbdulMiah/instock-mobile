import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/business/screens/business_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/back_button.dart';
import '../../../utilities/widgets/instock_button.dart';
import '../../../utilities/widgets/wave.dart';
import '../widgets/shop_connection_list.dart';

class ShopConnections extends StatefulWidget {
  const ShopConnections({Key? key}) : super(key: key);

  @override
  State<ShopConnections> createState() => _ShopConnectionsState();
}

class _ShopConnectionsState extends State<ShopConnections> {
  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: theme.themeData.splashColor),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
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
                              padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                              child: Text(
                                "Shop Connections",
                                style: theme.themeData.textTheme.bodyMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                            top: 10,
                            left: 10,
                            child: InStockBackButton(
                              page: BusinessPage(),
                              colorOption: InStockBackButton.secondary,
                            )
                        ),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Connections Info",
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                                          child: Text(
                                            "If you connect to a platform and create a new item with the same SKU as an item already on that platform, the two items will be linked together. Your items can be linked to multiple platforms simultaneously. Once they're linked, you'll be able to see the total number of pending orders from all platforms, and the platform's listed item quantity will automatically adjust to match the available stock (Total stock you listed - Live Orders = Available Stock). \n \nIf you change the total stock you have listed that will in turn change the available stock for your platforms and will cause that platforms stock listing amount to be updated.",
                                            style: theme.themeData.textTheme.bodySmall?.copyWith(fontSize: 16),
                                          ),
                                        ),
                                        Center(
                                          child: InStockButton(
                                            text: "Ok",
                                            onPressed: () {
                                              Navigator.pop(context); // Close the AlertDialog
                                            },
                                            theme: theme.themeData,
                                            colorOption: InStockButton.accent,
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                              },
                              child: const Icon(Icons.info_outline)
                            ),
                        ),
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          top: MediaQuery.of(context).size.height * 0.05 - 2,
                          child: const InStockWave(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 64.0, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          "Supercharge your stock management and connect all your shop channels",
                          style: theme.themeData.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0),
                          child: ShopConnectionList(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
