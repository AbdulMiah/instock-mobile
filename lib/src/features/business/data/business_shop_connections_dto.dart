import 'package:instock_mobile/src/features/business/data/shop_connections_dto.dart';

import '../../../utilities/data/error_notification.dart';

class BusinessConnectionsDto {
  final String? businessId;
  final List<ConnectionDto>? connections;
  final ErrorNotification errorNotification;

  BusinessConnectionsDto({
    required this.businessId,
    required this.connections,
    required this.errorNotification,
  });

  // This unholy factory is the result of error handling for the error notification pattern
  factory BusinessConnectionsDto.fromJson(Map<String, dynamic> json) {
    if (json['hasErrors'] == true) {
      Map<String, dynamic>? errorsJson = json['errors'];
      return BusinessConnectionsDto(
        businessId: null,
        connections: [],
        errorNotification: ErrorNotification(
          errors: errorsJson ?? {},
          hasErrors: true,
        ),
      );
    } else {
      return BusinessConnectionsDto(
        businessId: json['businessId'],
        connections: (json['connections'] as List)
            .map((connectionJson) => ConnectionDto.fromJson(connectionJson))
            .toList(),
        errorNotification: ErrorNotification(
          errors: {},
          hasErrors: false,
        ),
      );
    }
  }

  @override
  String toString() {
    return 'BusinessConnectionsDto{businessId: $businessId, connections: $connections, errorNotification: $errorNotification}';
  }
}
