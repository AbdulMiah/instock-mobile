class Item {
  final String SKU;
  final String businessId;
  final String category;
  final String name;
  final String stock;

  const Item({
    required this.SKU,
    required this.businessId,
    required this.category,
    required this.name,
    required this.stock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      SKU: json['SKU'],
      businessId: json['BusinessId'],
      category: json['Category'],
      name: json['Name'],
      stock: json['Stock'],
    );
  }
}
