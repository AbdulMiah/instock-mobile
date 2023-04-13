import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/services/config_service.dart';
import '../../authentication/services/authentication_service.dart';
import '../data/add_shop_connection_dto.dart';
import '../data/business_shop_connections_dto.dart';

class ShopConnectionService {
  final AuthenticationService _authenticationService = AuthenticationService();
  final http.Client client = http.Client();

  Future<BusinessConnectionsDto> getBusinessesCurrentConnections() async {
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

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    BusinessConnectionsDto connections =
        BusinessConnectionsDto.fromJson(jsonResponse);

    return connections;
  }

  Future<BusinessConnectionsDto> addShopConnection(
      AddShopConnectionDto addShopConnectionDto) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    final uri = Uri.parse('$url/businesses/$businessId/connections');

    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: addShopConnectionDto.toJson(),
    );

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    BusinessConnectionsDto connections =
        BusinessConnectionsDto.fromJson(jsonResponse);

    return connections;
  }
}
