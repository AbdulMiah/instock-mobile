class Item {
  final String sku;
  final String? businessId;
  final String category;
  final String name;
  final String stock;

  const Item({
    required this.sku,
    this.businessId,
    required this.category,
    required this.name,
    required this.stock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      sku: json['SKU'],
      businessId: json['BusinessId'],
      category: json['Category'],
      name: json['Name'],
      stock: json['Stock'],
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category,
    'stock': stock,
    'sku': sku,
  };

  @override
  String toString() {
    return 'Item{SKU: $sku, businessId: $businessId, category: $category, name: $name, stock: $stock}';
  }
}
