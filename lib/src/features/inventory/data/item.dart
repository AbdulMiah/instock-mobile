class Item {
  final String sku;
  final String? businessId;
  final String category;
  final String name;
  final int stockAmount;
  final int ordersAmount;

  const Item({
    required this.sku,
    required this.businessId,
    required this.category,
    required this.name,
    required this.stockAmount,
    required this.ordersAmount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      sku: json['SKU'],
      businessId: json['BusinessId'],
      category: json['Category'],
      name: json['Name'],
      stockAmount: int.parse(json['Stock']),
      ordersAmount: 0,
    );
  }

  @override
  String toString() {
    return 'Item{sku: $sku, businessId: $businessId, category: $category, name: $name, stockAmount: $stockAmount, ordersAmount: $ordersAmount}';
  }
}
