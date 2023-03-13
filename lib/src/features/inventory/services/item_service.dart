import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';
import '../../authentication/services/authentication_service.dart';

class ItemService {
  Future<ResponseObject> addItem(String name, String category, String stockLevel, String sku) async {
    var tokenDict = await AuthenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    final url = Uri.parse('https://localhost:7082/businesses/$businessId/items');
    var data = Map<String, dynamic>();
    data['name'] = name;
    data['category'] = category;
    data['stock'] = stockLevel;
    data['sku'] = sku;

    var body = json.encode(data);

    final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body
    );

    ResponseObject responseObject =
    ResponseObject(response.statusCode, response.body);

    print(response.statusCode);

    return (responseObject);
  }
}
