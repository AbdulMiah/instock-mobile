import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instock_mobile/src/features/account/data/user_dto.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../../../utilities/services/config_service.dart';
import '../../authentication/services/authentication_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';

class UserService {
  final IAuthenticationService _authenticationService = AuthenticationService();

  Future<UserDto> getUser() async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    String email = payload["Email"];

    String url = ConfigService.url;
    final uri = Uri.parse('$url/users/$email');

    final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          "Content-Type": "application/json"
        },
    );

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      UserDto userDto = UserDto.fromJson(userJson);
      return userDto;
    } else {
      throw Exception('Failed to get user details');
    }
  }
}