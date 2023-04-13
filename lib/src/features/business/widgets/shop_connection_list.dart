import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/business/services/shop_connection_service.dart';

import '../../../theme/common_theme.dart';

class ShopConnectionList extends StatefulWidget {
  const ShopConnectionList({Key? key}) : super(key: key);

  @override
  State<ShopConnectionList> createState() => _ShopConnectionListState();
}

class _ShopConnectionListState extends State<ShopConnectionList> {
  ShopConnectionService shopConnectionService = ShopConnectionService();

  getAvailableShopConnections() {
    shopConnectionService.getBusinessesCurrentConnections();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme();
    getAvailableShopConnections();
    return Container(
      child: Text("Test"),
    );
  }
}
