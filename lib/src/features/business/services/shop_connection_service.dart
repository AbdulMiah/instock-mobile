import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/services/config_service.dart';
import '../../authentication/services/authentication_service.dart';

class ShopConnectionService {
  final AuthenticationService _authenticationService = AuthenticationService();
  final http.Client client = http.Client();

  getBusinessesCurrentConnections() async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    final uri = Uri.parse('$url/businesses/$businessId/connections');

    final response = await client.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print("== Running ==");
    print(response);
    print("==============");
    print(response.body);
  }
}
