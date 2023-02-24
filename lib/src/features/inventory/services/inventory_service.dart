import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/inventory/data/item.dart';

class InventoryService {
  Future<List<Item>> getItems() async {
    print("in inventory service");
    var response = await http.get(Uri.parse(
        "https://api.json-generator.com/templates/QqZmEQPf6dQR/data?access_token=token"));
    var jsonData = json.decode(response.body);

    List<Item> items = [];

    for (var i in jsonData) {
      Item item = Item.fromJson(i);
      items.add(item);
    }
    return items;
  }
}
