import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/inventory/data/stock_update_dto.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/config_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';
import '../data/specific_item_dto.dart';

@injectable
class ItemService {
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future<ResponseObject> updateStockAmount(
      StockUpdateDTO stockUpdateDTO) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];

    String url = ConfigService.url;

    final uri = Uri.parse(
        '$url/businesses/${stockUpdateDTO.businessId}/items/${stockUpdateDTO.sku}/stock/updates');

    var data = Map<String, dynamic>();
    data["changeStockAmountBy"] = stockUpdateDTO.changeInStockAmount.toString();
    data["reasonForChange"] = stockUpdateDTO.reasonForChange.name;

    var body = json.encode(data);

    final response = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body);

    Map<String, dynamic> responseMap = json.decode(response.body);
    List<String> responseErrors =
        ResponseObject.extractErrorsFromResponse(responseMap);
    if (responseErrors.isEmpty) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      return ResponseObject(
        statusCode: response.statusCode,
        body: decodedData,
        requestSuccess: true,
      );
    } else {
      ResponseObject responseObject = ResponseObject(
          statusCode: response.statusCode,
          body: "Whoops something went wrong, please try again",
          requestSuccess: false,
          errors: responseErrors);
      return responseObject;
    }
  }

  Future<ResponseObject> delete(String itemId) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    String businessId = payload["BusinessId"];

    String url = ConfigService.url;
    var uri = Uri.parse('$url/businesses/$businessId/items/$itemId');
    final response = await http.delete(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    bool requestSuccess = false;
    if (response.statusCode == 200) {
      requestSuccess = true;
    }

    ResponseObject responseObject = ResponseObject(
        statusCode: response.statusCode,
        body: response.body,
        requestSuccess: requestSuccess);
    // create response object
    return responseObject;
  }

  Future<SpecificItemDto> getItem(String sku) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    final uri = Uri.parse('$url/businesses/$businessId/items/$sku');

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return SpecificItemDto.fromJson(jsonData);
    } else {
      throw Exception('Failed to load item');
    }
  }
}
