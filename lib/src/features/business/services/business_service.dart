import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/features/authentication/services/interfaces/Iauthentication_service.dart';
import 'package:instock_mobile/src/features/business/data/AddNewBusinessDto.dart';
import 'package:instock_mobile/src/features/business/data/business_dto.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';

class BusinessService {
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future<Business> getBusiness(http.Client client) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    final uri = Uri.parse('http://api.instockinventory.co.uk/businesses/$businessId');

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

  Future<ResponseObject> addBusiness(AddNewBusinessDto business) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];

    final uri = Uri.parse('http://api.instockinventory.co.uk/business');

    final request = http.MultipartRequest('POST', uri);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';

    // Add the fields to the request
    request.fields.addAll(business.toJson());

    // Add the image file to the request
    final imageFile = business.imageFile;
    if (imageFile != null) {
      final fileExtension = path.extension(imageFile.path).substring(1);
      request.files.add(
          await http.MultipartFile.fromPath(
              'imageFile',
              imageFile.path,
              contentType: MediaType('image', fileExtension)
          )
      );
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseMap = json.decode(responseBody);
    List<String> responseErrors =
        ResponseObject.extractErrorsFromResponse(responseMap);
    if (responseErrors.isEmpty) {
      String bearerToken = responseMap["newJwtToken"];
      await _authenticationService.saveBearerToken(bearerToken);
      return ResponseObject(
        statusCode: response.statusCode,
        body: responseBody,
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

  Future<bool> doesBusinessExist() async {
    AuthenticationService authenticationService = AuthenticationService();

    // Get token and check if businessId is null
    var tokenDict = await authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    String businessId = payload["BusinessId"];

    if (businessId == "") {
      return false;
    }

    return true;
  }
}
