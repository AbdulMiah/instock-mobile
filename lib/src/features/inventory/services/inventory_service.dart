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

    String businessId = payload["BusinessIds"];
    String url = "api.instockinventory.co.uk";

    print("token: $token");
    Map<String, String> queryParams = {'businessId': businessId};

    // var uri = Uri.http(url, '/items', queryParams);
    // print(uri);

    final response = await http.get(
      Uri.parse(
          'http://api.instockinventory.co.uk/items?businessId=2a36f726-b3a2-11ed-afa1-0242ac120002'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    // final response = await http.get(Uri.parse(url3));

    print(response);
    var jsonData = json.decode(response.body);
    print(jsonData);

    if (response.statusCode == 200) {
      print(response.statusCode);
      var jsonData = json.decode(response.body);
      List<Item> items = [];

      for (var i in jsonData) {
        Item item = Item.fromJson(i);
        items.add(item);
      }
      items.sort((a, b) => a.category.compareTo(b.category));
      return items;
    } else {
      print("failed: $response.statusCode");
      throw Exception('Failed to load items');
    }
  }
}
