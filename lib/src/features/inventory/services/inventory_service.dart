import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/features/inventory/data/item.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/config_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';
import '../data/add_new_item_dto.dart';

@injectable
class InventoryService {
  final IAuthenticationService _authenticationService;

  InventoryService(this._authenticationService);

  Future<List<Item>> getItems(http.Client client) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    final uri = Uri.parse('$url/businesses/$businessId/items');

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

  Future<ResponseObject> addItem(AddNewItemDto item) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    final uri = Uri.parse('$url/businesses/$businessId/items');

    final request = http.MultipartRequest('POST', uri);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';

    // Add the fields to the request
    request.fields.addAll(item.toJson());

    // Add the image file to the request
    final imageFile = item.imageFile;
    if (imageFile != null) {
      final fileExtension = path.extension(imageFile.path).substring(1);
      request.files.add(
          await http.MultipartFile.fromPath(
              'imageFile',
              imageFile.path,
              contentType: MediaType('image', fileExtension)
          )
      );
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    ResponseObject responseObject = ResponseObject(
        statusCode: response.statusCode,
        body: responseBody
    );

    return (responseObject);
  }
}
