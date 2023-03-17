import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/authentication/data/sign_up_dto.dart';
import 'package:instock_mobile/src/features/authentication/services/interfaces/Iauthentication_service.dart';
import 'package:instock_mobile/src/utilities/services/interfaces/Isecure_storage_service.dart';

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/secure_storage_service.dart';
import '../../../utilities/validation/validators.dart';

class AuthenticationService implements IAuthenticationService {
  static Future<AuthenticationService> init() async {
    return AuthenticationService();
  }

  final ISecureStorageService _secureStorageService = SecureStorageService();

  // Need to explorer injection further
  // AuthenticationService() {
  //   _secureStorageService = SecureStorageService();
  // }

  @override
  Future<ResponseObject> authenticateUser(String email, String password) async {
    Validators.isEmail(email);
    Validators.validatePassword(password);
    Validators.shortLength(email);
    Validators.shortLength(password);

    final uri = Uri.parse('http://api.instockinventory.co.uk/login');
    var data = Map<String, dynamic>();
    data['Email'] = email;
    data['Password'] = password;

    var body = json.encode(data);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
        ResponseObject(statusCode: response.statusCode, body: response.body);

    if (response.statusCode == 200) {
      String bearerToken = response.body;
      _saveBearerToken(bearerToken);
      return (responseObject);
    } else {
      return (responseObject);
    }
  }

  _saveBearerToken(String bearerToken) async {
    await _secureStorageService.write("bearerToken", bearerToken);
  }

  @override
  Future<Map> retrieveBearerToken() async {
    String? bearerToken = await _secureStorageService.get("bearerToken");
    Map tokenDict = {"bearerToken": bearerToken};
    return tokenDict;
  }

  @override
  Future<ResponseObject> createUserAndAuthenticate(
      SignUpDto userDetails) async {
    Validators.isEmail(userDetails.email);
    Validators.validatePassword(userDetails.password);
    Validators.shortLength(userDetails.email);
    Validators.shortLength(userDetails.password);

    final url = Uri.parse('http://api.instockinventory.co.uk/user');
    var data = Map<String, dynamic>();
    data['firstName'] = userDetails.firstName;
    data['lastName'] = userDetails.lastName;
    data['email'] = userDetails.email;
    data['password'] = userDetails.password;

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
        ResponseObject(statusCode: response.statusCode, body: response.body);
    if (response.statusCode == 201) {
      String bearerToken = response.body;
      _saveBearerToken(bearerToken);
      return (responseObject);
    } else {
      return (responseObject);
    }
  }

  @override
  Future<ResponseObject> logOut() async {
    try {
      await _secureStorageService.delete("bearerToken");
      return ResponseObject(requestSuccess: true, body: "Logged Out");
    } catch (error) {
      return ResponseObject(
          requestSuccess: false, body: "Oops Something went wrong");
    }
  }
}
