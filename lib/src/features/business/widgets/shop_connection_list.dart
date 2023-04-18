import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/data/business_shop_connections_dto.dart';
import 'package:instock_mobile/src/features/business/services/shop_connection_service.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_connection_card.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_success_alert.dart';
import 'package:instock_mobile/src/utilities/widgets/no_internet_page.dart';

import '../../../theme/common_theme.dart';
import '../../../utilities/widgets/loading_spinner.dart';

class ShopConnectionList extends StatefulWidget {
  const ShopConnectionList({Key? key}) : super(key: key);

  @override
  State<ShopConnectionList> createState() => _ShopConnectionListState();
}

class _ShopConnectionListState extends State<ShopConnectionList> {
  ShopConnectionService shopConnectionService = ShopConnectionService();
  Map<String, bool> connectedStates = {};

  Future<BusinessConnectionsDto> getAvailableShopConnections() async {
    BusinessConnectionsDto connectionsList =
        await shopConnectionService.getBusinessesCurrentConnections();

    return connectionsList;
  }

  bool isConnected(connectionsList, platformName) {
    if (connectionsList.connections
        .any((connection) => connection.platformName == platformName)) {
      connectedStates[platformName] = true;
      return true;
    } else {
      connectedStates[platformName] = false;
      return false;
    }
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return FutureBuilder<BusinessConnectionsDto>(
      future: getAvailableShopConnections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingSpinner());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (snapshot.error is SocketException) {
            return NoInternetPage(refreshFunc: refreshPage);
          } else
            return SingleChildScrollView(
              child: Column(
                children: [
                  ShopConnectionCard(
                    title: 'Mock Etsy',
                    imageUrl:
                        'https://instock-shop-connection-icons.s3.eu-west-2.amazonaws.com/etsyLogo.jpeg',
                    description: 'For all things mocked and stocked',
                    connected: isConnected(snapshot.data!, "Mock Etsy"),
                    onConnectionChanged: (bool connected) async {
                      setState(() {
                        connectedStates["mockshop"] = connected;
                      });
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShopSignInSuccessAlert(
                            themeData: theme.themeData,
                            text: "Connected to Mock Etsy",
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
                    child: ShopConnectionCard(
                      title: 'Mock Shopify',
                      imageUrl:
                          'https://instock-shop-connection-icons.s3.eu-west-2.amazonaws.com/shopifyLogo.png',
                      description:
                          'Making a mockery of other business platforms',
                      connected: isConnected(snapshot.data!, "Mock Shopify"),
                      onConnectionChanged: (bool connected) async {
                        setState(() {
                          connectedStates["mockmarket"] = connected;
                        });
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShopSignInSuccessAlert(
                                themeData: theme.themeData,
                                text: "Connected to Mock Shopify");
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
