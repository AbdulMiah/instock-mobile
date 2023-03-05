import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/wave.dart';
import '../widgets/inventory_builder.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  // checkStatus(AsyncSnapshot snapshot, int index)

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();

    var inventoryService = InventoryService();

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
                                "Inventory",
                                style: theme.themeData.textTheme.bodyMedium
                                    ?.merge(const TextStyle(fontSize: 24)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: InventoryBuilder(
                              inventoryService: inventoryService, theme: theme),
                        ),
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