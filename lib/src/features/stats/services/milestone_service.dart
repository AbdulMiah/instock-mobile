import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../utilities/services/config_service.dart';
import '../../authentication/data/identity_dto.dart';
import '../../authentication/services/authentication_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';
import '../data/milestone_dto.dart';
import '../data/milestone_list_dto.dart';

class MilestoneService {
  final IAuthenticationService _authenticationService = AuthenticationService();
  final http.Client client = http.Client();

  MilestoneService();

  Future<MilestoneListDto> getMilestones() async {
    try {
      IdentityDto identityDto =
          await _authenticationService.getUserIdAndBusiness();

      String url = ConfigService.url;

      final uri = Uri.parse('$url/milestones/${identityDto.businessId}');

      final response = await client.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${identityDto.authToken}',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        MilestoneListDto milestoneListDto = MilestoneListDto.fromJson(jsonData);
        return milestoneListDto;
      } else {
        throw Exception('Error retrieving milestones');
      }
    } catch (e) {
      throw Exception('Could not retrieve milestones: ${e.toString()}');
    }
  }

  Future<MilestoneDto> hideMilestone(String milestoneId) async {
    try {
      IdentityDto identityDto =
          await _authenticationService.getUserIdAndBusiness();

      String url = ConfigService.url;

      final uri = Uri.parse('$url/milestones/$milestoneId/hide');

      final response = await client.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${identityDto.authToken}',
        },
      );

      var jsonData = json.decode(response.body);
      MilestoneDto milestoneDto = MilestoneDto.fromJsonPost(jsonData);
      return milestoneDto;
    } catch (exception) {
      throw Exception('Error hiding milestone: ${exception.toString()}');
    }
  }
}
