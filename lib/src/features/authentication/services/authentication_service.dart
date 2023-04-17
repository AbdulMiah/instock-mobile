import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:instock_mobile/src/features/authentication/data/login_dto.dart';
import 'package:instock_mobile/src/features/authentication/data/sign_up_dto.dart';
import 'package:instock_mobile/src/features/authentication/services/interfaces/Iauthentication_service.dart';
import 'package:instock_mobile/src/utilities/services/interfaces/Isecure_storage_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:path/path.dart' as path;

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/config_service.dart';
import '../../../utilities/services/secure_storage_service.dart';
import '../../../utilities/validation/validators.dart';
import '../data/identity_dto.dart';

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
  Future<ResponseObject> authenticateUser(LoginDto loginDto) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    Validators.isEmail(loginDto.email);
    Validators.validatePassword(loginDto.password);
    Validators.shortLength(loginDto.email);
    Validators.shortLength(loginDto.password);

    String url = ConfigService.url;

    final uri = Uri.parse('$url/login');

    var body = json.encode(loginDto.toJson(fcmToken!));

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
        ResponseObject(statusCode: response.statusCode, body: response.body);

    if (response.statusCode == 200) {
      print("================= Token ===================");
      print(fcmToken);
      String bearerToken = response.body;
      saveBearerToken(bearerToken);
      _saveFcmToken(fcmToken);
      return (responseObject);
    } else {
      return (responseObject);
    }
  }

  @override
  Future<ResponseObject> saveBearerToken(String bearerToken) async {
    try {
      await _secureStorageService.write("bearerToken", bearerToken);
      return ResponseObject(requestSuccess: true, body: "Bearer Token Saved");
    } catch (error) {
      return ResponseObject(
          requestSuccess: false, body: "Oops Something went wrong");
    }
  }

  _saveFcmToken(String fcmToken) async {
    await _secureStorageService.write("fcmToken", fcmToken);
  }

  @override
  Future<Map> retrieveBearerToken() async {
    String? bearerToken = await _secureStorageService.get("bearerToken");
    Map tokenDict = {"bearerToken": bearerToken};
    return tokenDict;
  }

  @override
  Future<Map> retrieveFcmToken() async {
    String? fcmToken = await _secureStorageService.get("fcmToken");
    Map tokenDict = {"fcmToken": fcmToken};
    return tokenDict;
  }

  @override
  Future<ResponseObject> createUserAndAuthenticate(
      SignUpDto userDetails) async {
    Validators.isEmail(userDetails.email);
    Validators.validatePassword(userDetails.password);
    Validators.shortLength(userDetails.email);
    Validators.shortLength(userDetails.password);

    String url = ConfigService.url;

    final uri = Uri.parse('$url/user');

    final request = http.MultipartRequest('POST', uri);

    // Add the fields to the request
    request.fields.addAll(userDetails.toJson());

    // Add the image file to the request
    final imageFile = userDetails.imageFile;
    if (imageFile != null) {
      final fileExtension = path.extension(imageFile.path).substring(1);
      request.files.add(await http.MultipartFile.fromPath(
          'imageFile', imageFile.path,
          contentType: MediaType('image', fileExtension)));
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    ResponseObject responseObject =
        ResponseObject(statusCode: response.statusCode, body: responseBody);
    if (response.statusCode == 201) {
      String bearerToken = responseBody;
      saveBearerToken(bearerToken);
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

  @override
  Future<IdentityDto> getUserIdAndBusiness() async {
    try {
      var tokenDict = await retrieveBearerToken();
      String? token = tokenDict["bearerToken"];
      if (token == null) {
        throw Exception('Failed to retrieve bearer token');
      }

      Map<String, dynamic> payload = Jwt.parseJwt(token);
      String? businessId = payload["BusinessId"];
      if (businessId == null) {
        throw Exception('Failed to retrieve business ID from token payload');
      }

      return IdentityDto(businessId: businessId, authToken: token);
    } catch (exception) {
      throw Exception(
          'Could not retrieve identity details: ${exception.toString()}');
    }
  }
}
