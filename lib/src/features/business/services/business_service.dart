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

    if (response.statusCode == 201) {
      ResponseObject(
        statusCode: response.statusCode,
        body: response.body,
        requestSuccess: true,
      );
    } else {
      print(response.body);
      Map<String, dynamic> responseMap = response.body as Map<String, dynamic>;

      List<String> errors = extractErrorMessages(responseMap);

      ResponseObject responseObject = ResponseObject(
          statusCode: response.statusCode,
          body: "Whoops something went wrong, please try again",
          requestSuccess: true,
          errors: errors);

      print(responseObject.toString());
    }

    ResponseObject responseObject =
        ResponseObject(statusCode: response.statusCode, body: response.body);

    return (responseObject);
  }

  List<String> extractErrorMessages(Map<String, dynamic> dictionary) {
    List<String> errorMessages = [];
    if (dictionary.containsKey('errors')) {
      Map<String, dynamic> errors = dictionary['errors'];
      errors.forEach((key, value) {
        if (value is List) {
          value.forEach((element) {
            if (element is String) {
              errorMessages.add(element);
            }
          });
        }
      });
    }
    return errorMessages;
  }
}
