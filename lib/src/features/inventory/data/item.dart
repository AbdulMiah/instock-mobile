class Item {
  final String sku;
  final String businessId;
  final String category;
  final String name;
  final int stockAmount;
  final int totalStock;
  final int totalOrders;
  final int availableStock;
  String? itemWarning;
  final String itemImgUrl;

  Item({
    required this.sku,
    required this.businessId,
    required this.category,
    required this.name,
    required this.stockAmount,
    required this.totalStock,
    required this.totalOrders,
    required this.availableStock,
    required this.itemWarning,
    required this.itemImgUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'BusinessId': businessId,
      'Category': category,
      'Name': name,
      'Stock': stockAmount,
      'TotalStock': totalStock,
      'TotalOrders': totalOrders,
      'AvailableStock': availableStock,
      'itemWarning': itemWarning,
      'ImageUrl': itemImgUrl,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      sku: json['SKU'],
      businessId: json['BusinessId'],
      category: json['Category'],
      name: json['Name'],
      stockAmount: int.parse(json['Stock']),
      totalStock: int.parse(json['TotalStock']),
      totalOrders: int.parse(json['TotalOrders']),
      availableStock: int.parse(json['AvailableStock']),
      itemWarning: json['itemWarning'],
      itemImgUrl: json['ImageUrl'],
    );
  }

  @override
  String toString() {
    return 'Item{sku: $sku, businessId: $businessId, category: $category, name: $name, stockAmount: $stockAmount, totalStock: $totalStock, totalOrders: $totalOrders, availableStock: $availableStock}';
  }
}
