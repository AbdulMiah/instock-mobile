import 'package:instock_mobile/src/features/business/data/shop_connections_dto.dart';

import '../../../utilities/data/error_notification.dart';

class BusinessConnectionsDto {
  final String businessId;
  final List<ConnectionDto> connections;
  final ErrorNotification errorNotification;

  BusinessConnectionsDto({
    required this.businessId,
    required this.connections,
    required this.errorNotification,
  });

  factory BusinessConnectionsDto.fromJson(Map<String, dynamic> json) {
    return BusinessConnectionsDto(
      businessId: json['businessId'],
      connections: (json['connections'] as List)
          .map((connectionJson) => ConnectionDto.fromJson(connectionJson))
          .toList(),
      errorNotification: ErrorNotification.fromJson(json['errorNotification']),
    );
  }
}
