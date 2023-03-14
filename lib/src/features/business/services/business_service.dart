import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/authentication/services/interfaces/Iauthentication_service.dart';

import '../../../utilities/objects/response_object.dart';

class BusinessService {
  IAuthenticationService _authenticationService = AuthenticationService();

  Future<ResponseObject> addBusiness(String name, String description) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];

    final url = Uri.parse('http://api.instockinventory.co.uk/business');
    var data = Map<String, dynamic>();
    data['businessName'] = name;
    data['businessDescription'] = description;

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body);

    ResponseObject responseObject =
        ResponseObject(response.statusCode, response.body);

    return (responseObject);
  }
}
