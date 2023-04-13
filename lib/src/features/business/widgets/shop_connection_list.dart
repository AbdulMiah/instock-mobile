import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/data/business_shop_connections_dto.dart';
import 'package:instock_mobile/src/features/business/services/shop_connection_service.dart';
import 'package:instock_mobile/src/features/business/widgets/shop_connection_card.dart';

import '../../../theme/common_theme.dart';

class ShopConnectionList extends StatefulWidget {
  const ShopConnectionList({Key? key}) : super(key: key);

  @override
  State<ShopConnectionList> createState() => _ShopConnectionListState();
}

class _ShopConnectionListState extends State<ShopConnectionList> {
  ShopConnectionService shopConnectionService = ShopConnectionService();

  Future<BusinessConnectionsDto> getAvailableShopConnections() async {
    BusinessConnectionsDto connectionsList =
        await shopConnectionService.getBusinessesCurrentConnections();

    connectionsList.connections.forEach((connection) {
      print(connection.platformName);
    });
    return connectionsList;
  }

  bool isConnected(connectionsList, platformName) {
    // Generated using github co pilot
    // only entered method name and if statement
    // co pilot generated the rest (it even generated some of this comment
    // as I was typing it).
    print("Running");
    if (connectionsList.connections
        .any((connection) => connection.platformName == platformName)) {
      print("Connected to $platformName");
      return true;
    } else {
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
                  connected: isConnected(snapshot.data!, "mockshop"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  child: ShopConnectionCard(
                    title: 'Mock Shopify',
                    imageUrl:
                        'https://instock-shop-connection-icons.s3.eu-west-2.amazonaws.com/shopifyLogo.png',
                    description: 'Making a mockery of other business platforms',
                    connected: isConnected(snapshot.data!, "mockmarket"),
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
