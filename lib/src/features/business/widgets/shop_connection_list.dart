import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/data/business_shop_connections_dto.dart';
import 'package:instock_mobile/src/features/business/services/shop_connection_service.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_connection_card.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_sign_in_success_alert.dart';

import '../../../theme/common_theme.dart';

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

    connectionsList.connections!.forEach((connection) {
      print(connection.platformName);
    });
    return connectionsList;
  }

  bool isConnected(connectionsList, platformName) {
    if (connectionsList.connections
        .any((connection) => connection.platformName == platformName)) {
      print("Connected to $platformName");
      connectedStates[platformName] = true;
      return true;
    } else {
      connectedStates[platformName] = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    return FutureBuilder<BusinessConnectionsDto>(
      future: getAvailableShopConnections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                ShopConnectionCard(
                  title: 'Mock Etsy',
                  imageUrl:
                      'https://instock-shop-connection-icons.s3.eu-west-2.amazonaws.com/etsyLogo.jpeg',
                  description: 'For all things mocked and stocked',
                  connected: isConnected(snapshot.data!, "Mock Etsy"),
                  onConnectionChanged: (bool connected) {
                    print("Its connected");
                    setState(() {
                      connectedStates["mockshop"] = connected;
                    });
                  },
                ),
// ...
                ShopConnectionCard(
                  title: 'Mock Shopify',
                  imageUrl:
                      'https://instock-shop-connection-icons.s3.eu-west-2.amazonaws.com/shopifyLogo.png',
                  description: 'Making a mockery of other business platforms',
                  connected: isConnected(snapshot.data!, "Mock Shopify"),
                  onConnectionChanged: (bool connected) async {
                    print("Its connected");
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
              ],
            ),
          );
        }
      },
    );
  }
}
