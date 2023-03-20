import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/wave.dart';
import '../../authentication/services/authentication_service.dart';
import '../widgets/inventory_builder.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final InventoryService _inventoryService =
      InventoryService(AuthenticationService());

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return Scaffold(
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
                          inventoryService: _inventoryService,
                          theme: theme,
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: MediaQuery.of(context).size.height * 0.05 - 2,
                        child: const InStockWave(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
