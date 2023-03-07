import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utilities/objects/response_object.dart';

class BusinessService {
  Future<ResponseObject> addBusiness(String name, String description) async {
    final url = Uri.parse('http://api.instockinventory.co.uk/business');
    var data = Map<String, dynamic>();
    data['Name'] = name;
    data['Description'] = description;

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
    ResponseObject(response.statusCode, response.body);

    if (response.statusCode == 201) {
      return (responseObject);
    } else {
      return (responseObject);
    }
  }
}
