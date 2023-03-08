import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../utilities/objects/response_object.dart';
import '../../authentication/services/authentication_service.dart';

class BusinessService {
  Future<ResponseObject> addBusiness(String name, String description) async {
    print("in business service");
    var tokenDict = await AuthenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];

    final url = Uri.parse('http://api.instockinventory.co.uk/business');
    var data = Map<String, dynamic>();
    data['businessName'] = name;
    data['businessDescription'] = description;

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

    if (response.statusCode == 201) {
      return (responseObject);
    } else {
      return (responseObject);
    }
  }
}
