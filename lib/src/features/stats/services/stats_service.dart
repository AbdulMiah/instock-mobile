import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/features/stats/data/stats_dto.dart';
import 'package:jwt_decode/jwt_decode.dart';

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

    var statsDto = StatsDto(overallShopPerformance: {
      "sales": 98,
      "orders": 102,
      "corrections": 6,
      "returns": 2,
      "giveaways": 10,
      "damaged": 1,
      "restocked": 50,
      "lost": 0
    }, performanceByCategory: {
      "cards": {
        "sales": 40,
        "orders": 42,
        "corrections": 5,
        "returns": 0,
        "giveaways": 5,
        "damaged": 1,
        "restocked": 30,
        "lost": 0
      },
      "stickers": {
        "sales": 22,
        "orders": 24,
        "corrections": 1,
        "returns": 2,
        "giveaways": 3,
        "damaged": 0,
        "restocked": 20,
        "lost": 0
      },
      "bookmarks": {
        "sales": 34,
        "orders": 36,
        "corrections": 0,
        "returns": 0,
        "giveaways": 2,
        "damaged": 0,
        "restocked": 0,
        "lost": 0
      }
    }, salesByMonth: {
      "October": 10,
      "November": 20,
      "December": 15,
      "January": 12,
      "February": 25,
      "March": 20
    }, deductionsByMonth: {
      "October": 2,
      "November": 4,
      "December": 3,
      "January": 1,
      "February": 5,
      "March": 5
    });
    return statsDto;

    // final uri = Uri.parse(
    //     'http://api.instockinventory.co.uk/businesses/$businessId/items');
    //
    // final response = await client.get(
    //   uri,
    //   headers: {
    //     HttpHeaders.authorizationHeader: 'Bearer $token',
    //   },
    // );
    // if (response.statusCode == 200) {
    //   var jsonData = json.decode(response.body);
    //   List<Item> items = [];
    //
    //   for (var itemJson in jsonData) {
    //     Item item = Item.fromJson(itemJson);
    //     items.add(item);
    //   }
    //   items.sort((a, b) => a.category.compareTo(b.category));
    //   return items;
    // } else {
    //   throw Exception('Failed to load items');
    // }
  }
}
