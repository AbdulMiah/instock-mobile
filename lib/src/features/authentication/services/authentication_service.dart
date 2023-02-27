import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:instock_mobile/src/util/SecureStorageService.dart';
import 'package:instock_mobile/src/util/WidgetOptions/Validators.dart';

class AuthenticationService {
  Future<Response> authenticateUser(String email, String password) async {
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

    if (response.statusCode == 200) {
      String bearerToken = response.body;
      _saveBearerToken(bearerToken);
      return (response);
    } else {
      return (response);
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
