import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/data/item.dart';

class InventoryService {
  Future<List<Item>> getItems(http.Client client) async {
    String url =
        "https://api.json-generator.com/templates/QqZmEQPf6dQR/data?access_token=token";
    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Item> items = [];

      for (var i in jsonData) {
        Item item = Item.fromJson(i);
        items.add(item);
      }
      items.sort((a, b) => a.category.compareTo(b.category));
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }
}
