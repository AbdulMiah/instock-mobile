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
    _validateUserCredentialsInput(email, password);

    final uri = Uri.parse('http://api.instockinventory.co.uk/login');
    var data = Map<String, dynamic>();
    data['Email'] = email;
    data['Password'] = password;

    var body = json.encode(data);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    return _handleAuthenticationResponse(response, 200);
  }

  saveBearerToken(String bearerToken) async {
    await _secureStorageService.write("bearerToken", bearerToken);
  }

  @override
  Future<Map> retrieveBearerToken() async {
    String? bearerToken = await _secureStorageService.get("bearerToken");
    Map tokenDict = {"bearerToken": bearerToken};
    return tokenDict;
  }

  @override
  Future<ResponseObject> signUpUserAndAuthenticate(
      SignUpDto userDetails) async {
    _validateUserCredentialsInput(userDetails.email, userDetails.password);

    final url = Uri.parse('http://api.instockinventory.co.uk/user');
    var data = Map<String, dynamic>();
    data['firstName'] = userDetails.firstName;
    data['lastName'] = userDetails.lastName;
    data['email'] = userDetails.email;
    data['password'] = userDetails.password;

    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    return _handleAuthenticationResponse(response, 201);
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

ResponseObject _handleAuthenticationResponse(
    http.Response response, int successStatusCode) {
  ResponseObject responseObject =
      ResponseObject(statusCode: response.statusCode, body: response.body);

  if (response.statusCode == successStatusCode) {
    String bearerToken = response.body;
    _saveBearerToken(bearerToken);
  }

  return responseObject;
}

void _validateUserCredentialsInput(String email, String password) {
  Validators.isEmail(email);
  Validators.validatePassword(password);
  Validators.shortLength(email);
  Validators.shortLength(password);
}
