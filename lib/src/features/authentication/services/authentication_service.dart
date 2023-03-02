import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/secure_storage_service.dart';
import '../../../utilities/validation/validators.dart';

class AuthenticationService {
  Future<ResponseObject> authenticateUser(String email, String password) async {
    Validators.isEmail(email);
    Validators.validatePassword(password);
    Validators.shortLength(email);
    Validators.shortLength(password);

    final url = Uri.parse('http://api.instockinventory.co.uk/login');
    var data = new Map<String, dynamic>();
    data['Email'] = email;
    data['Password'] = password;

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
        ResponseObject(response.statusCode, response.body);

    if (response.statusCode == 200) {
      String bearerToken = response.body;
      _saveBearerToken(bearerToken);
      return (responseObject);
    } else {
      return (responseObject);
    }
  }

  _saveBearerToken(String bearerToken) async {
    SecureStorageService secureStorage = SecureStorageService();
    await secureStorage.write("bearerToken", bearerToken);
  }

  static Future<Map> retrieveBearerToken() async {
    SecureStorageService secureStorage = SecureStorageService();
    String? bearerToken = await secureStorage.get("bearerToken");
    Map tokenDict = {"bearerToken": bearerToken};
    return tokenDict;
  }
}
