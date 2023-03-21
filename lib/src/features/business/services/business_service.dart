import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/authentication/services/interfaces/Iauthentication_service.dart';
import 'package:instock_mobile/src/features/business/data/business.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';

class BusinessService {
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future<Business> getBusiness(http.Client client) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    // final uri = Uri.parse('http://api.instockinventory.co.uk/businesses/$businessId');
    final uri = Uri.parse('https://953w3.wiremockapi.cloud/json/1');

    final response = await client.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Business business = Business.fromJson(jsonData);
      return business;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResponseObject> addBusiness(String name, String description) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];

    final uri = Uri.parse('http://api.instockinventory.co.uk/business');
    var data = Map<String, dynamic>();
    data['businessName'] = name;
    data['businessDescription'] = description;

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
      return ResponseObject(
        statusCode: response.statusCode,
        body: response.body,
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
}
