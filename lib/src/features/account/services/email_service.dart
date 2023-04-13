import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/account/data/email_dto.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/config_service.dart';
import '../../authentication/services/authentication_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';

class EmailService {
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future<ResponseObject> sendMessage(EmailDto emailDto) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    String email = payload["Email"];

    String url = ConfigService.url;
    final uri = Uri.parse('$url/contact-us');

    var body = json.encode(emailDto.toJson(email));

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
    ResponseObject(statusCode: response.statusCode, body: response.body);

    return (responseObject);
  }
}