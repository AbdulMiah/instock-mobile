import '../../../utilities/data/error_notification.dart';

class ConnectedItemDto {
  final String? shopName;
  final int? totalStock;
  final int? availableStock;
  final int? totalOrders;
  final String? lastUpdated;
  final String? platformImageUrl;
  final ErrorNotification errorNotification;

  ConnectedItemDto({
    required this.shopName,
    required this.totalStock,
    required this.availableStock,
    required this.totalOrders,
    required this.lastUpdated,
    this.platformImageUrl,
    required this.errorNotification
  });

  Map<String, dynamic> toJson() {
    return {
      'shopName': lastUpdated,
      'totalStock': totalStock,
      'availableStock': availableStock,
      'totalOrders': totalOrders,
      'lastUpdated': lastUpdated,
      'platformImageUrl': platformImageUrl,
    };
  }

  factory ConnectedItemDto.fromJson(Map<String, dynamic> json) {
    if (json['hasErrors'] == true) {
      Map<String, dynamic>? errorsJson = json['errors'];
      return ConnectedItemDto(
        shopName: null,
        totalStock: null,
        availableStock: null,
        totalOrders: null,
        lastUpdated: null,
        errorNotification: ErrorNotification(
          errors: errorsJson ?? {},
          hasErrors: true,
        ),
      );
    } else {
      return ConnectedItemDto(
        shopName: json['shopName'],
        totalStock: int.parse(json['totalStock']),
        availableStock: int.parse(json['availableStock']),
        totalOrders: int.parse(json['totalOrders']),
        lastUpdated: json['lastUpdated'],
        platformImageUrl: json['platformImageUrl'],
        errorNotification: ErrorNotification(
          errors: {},
          hasErrors: false,
        ),
      );
    }
  }

  @override
  String toString() {
    return 'ConnectedItemDto{shopName: $shopName, totalStock: $totalStock, availableStock: $availableStock, totalOrders: $totalOrders, lastUpdated: $lastUpdated}';
  }

}
