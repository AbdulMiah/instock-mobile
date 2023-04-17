class ConnectedItemDto {
  final String shopName;
  final int totalStock;
  final int availableStock;
  final int totalOrders;
  final String lastUpdated;

  ConnectedItemDto({
    required this.shopName,
    required this.totalStock,
    required this.availableStock,
    required this.totalOrders,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() {
    return {
      'shopName': lastUpdated,
      'totalStock': totalStock,
      'availableStock': availableStock,
      'totalOrders': totalOrders,
      'lastUpdated': lastUpdated,
    };
  }

  factory ConnectedItemDto.fromJson(Map<String, dynamic> json) {
    return ConnectedItemDto(
      shopName: json['shopName'],
      totalStock: json['totalStock'],
      availableStock: json['availableStock'],
      totalOrders: json['totalOrders'],
      lastUpdated: json['lastUpdated'],
    );
  }

  @override
  String toString() {
    return 'ConnectedItemDto{shopName: $shopName, totalStock: $totalStock, availableStock: $availableStock, totalOrders: $totalOrders, lastUpdated: $lastUpdated}';
  }

}
