import 'package:instock_mobile/src/features/inventory/data/connected_item_dto.dart';

class SpecificItemDto {
  final String sku;
  final String name;
  final int totalStock;
  final int availableStock;
  final int totalOrders;
  final int totalSales;
  final String imageUrl;
  final List<ConnectedItemDto> connectedItems;

  SpecificItemDto({
    required this.sku,
    required this.name,
    required this.totalStock,
    required this.availableStock,
    required this.totalOrders,
    required this.totalSales,
    required this.imageUrl,
    required this.connectedItems,
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

    return SpecificItemDto(
      sku: json['sku'],
      name: json['name'],
      totalStock: json['totalStock'],
      availableStock: json['availableStock'],
      totalOrders: json['totalOrders'],
      totalSales: json['totalSales'],
      imageUrl: json['imageUrl'],
      connectedItems: connectedItems,
    );
  }

  @override
  String toString() {
    return 'SpecificItemDto{sku: $sku, name: $name, totalStock: $totalStock, availableStock: $availableStock, totalOrders: $totalOrders, totalSales: $totalSales, imageUrl: $imageUrl, connectedItems: $connectedItems}';
  }

}
