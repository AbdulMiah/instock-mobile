import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';

@injectable
class InventoryService {
  final IAuthenticationService _authenticationService;

  InventoryService(this._authenticationService);

  Future<List<Item>> getItems(http.Client client) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    final uri = Uri.parse(
        'http://api.instockinventory.co.uk/businesses/$businessId/items');

    final response = await client.get(
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

  Future<ResponseObject> addItem(Item item) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    final uri = Uri.parse(
        'http://api.instockinventory.co.uk/businesses/$businessId/items');

    var body = json.encode(item.toMap());

    final response = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body);

    ResponseObject responseObject =
        ResponseObject(statusCode: response.statusCode, body: response.body);

    return (responseObject);
  }
}
