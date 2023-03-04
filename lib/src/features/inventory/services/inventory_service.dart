import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:jwt_decode/jwt_decode.dart';

class InventoryService {
  Future<List<Item>> getItems(http.Client client) async {
    var tokenDict = await AuthenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessIdWithComma = payload["BusinessIds"];
    // currently a comma is returned because we are getting a list of one
    // businesses but this will change in the future
    String businessId =
        businessIdWithComma.substring(0, businessIdWithComma.length - 1);
    String url = "api.instockinventory.co.uk";

    Map<String, dynamic> queryParams = {'businessId': businessId};

    var uri = Uri.http(url, '/items', queryParams);

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Item> items = [];

      for (var itemJson in jsonData) {
        Item item = Item.fromJson(itemJson);
        items.add(item);
      }
      items.sort((a, b) => a.category.compareTo(b.category));
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }
}
