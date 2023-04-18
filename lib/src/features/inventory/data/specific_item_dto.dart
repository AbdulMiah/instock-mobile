import 'package:instock_mobile/src/features/inventory/data/connected_item_dto.dart';

import '../../../utilities/data/error_notification.dart';

class SpecificItemDto {
  final String? sku;
  final String? name;
  final int? totalStock;
  final int? availableStock;
  final int? totalOrders;
  final int? totalSales;
  final String? imageUrl;
  final List<ConnectedItemDto>? connectedItems;
  final ErrorNotification errorNotification;

  SpecificItemDto({
    required this.sku,
    required this.name,
    required this.totalStock,
    required this.availableStock,
    required this.totalOrders,
    required this.totalSales,
    required this.imageUrl,
    required this.connectedItems,
    required this.errorNotification
  });

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'name': name,
      'totalStock': totalStock,
      'availableStock': availableStock,
      'totalOrders': totalOrders,
      'totalSales': totalSales,
      'imageUrl': imageUrl,
      'connectedItems': connectedItems
    };
  }

  factory SpecificItemDto.fromJson(Map<String, dynamic> json) {
    List<dynamic> connectedItemsJson = json['connectedItems'] ?? [];

    List<ConnectedItemDto> connectedItems = connectedItemsJson
        .map((itemJson) => ConnectedItemDto.fromJson(itemJson))
        .toList();

    if (json['hasErrors'] == true) {
      Map<String, dynamic>? errorsJson = json['errors'];
      return SpecificItemDto(
        sku: null,
        name: null,
        totalStock: null,
        availableStock: null,
        totalOrders: null,
        totalSales: null,
        imageUrl: null,
        connectedItems: [],
        errorNotification: ErrorNotification(
          errors: errorsJson ?? {},
          hasErrors: true,
        ),
      );
    } else {
      return SpecificItemDto(
        sku: json['sku'],
        name: json['name'],
        totalStock: json['totalStock'],
        availableStock: json['availableStock'],
        totalOrders: json['totalOrders'],
        totalSales: json['totalSales'],
        imageUrl: json['imageUrl'],
        connectedItems: connectedItems,
        errorNotification: ErrorNotification(
          errors: {},
          hasErrors: false,
        ),
      );
    }
  }

  @override
  String toString() {
    return 'SpecificItemDto{sku: $sku, name: $name, totalStock: $totalStock, availableStock: $availableStock, totalOrders: $totalOrders, totalSales: $totalSales, imageUrl: $imageUrl, connectedItems: $connectedItems}';
  }

}
