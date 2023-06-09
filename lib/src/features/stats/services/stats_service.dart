import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/services/config_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';

@injectable
class StatsService {
  final IAuthenticationService _authenticationService;

  StatsService(this._authenticationService);

  Future<StatsDto> getStats(http.Client client) async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    final uri = Uri.parse('$url/statistics/$businessId');

    final response = await client.get(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      StatsDto statsDto = StatsDto.fromJson(jsonData);
      return statsDto;
    } else {
      throw Exception('Failed to load stats');
    }
  }
}
