class Item {
  final String sku;
  final String businessId;
  final String category;
  final String name;
  final int stockAmount;
  final int ordersAmount;
  String? itemWarning;
  final String itemImgUrl;

  Item({
    required this.sku,
    required this.businessId,
    required this.category,
    required this.name,
    required this.stockAmount,
    required this.ordersAmount,
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
      'ordersAmount': ordersAmount,
      'itemWarning': itemWarning,
      'itemImgUrl': itemImgUrl,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      sku: json['SKU'],
      businessId: json['BusinessId'],
      category: json['Category'],
      name: json['Name'],
      stockAmount: int.parse(json['Stock']),
      ordersAmount: 0,
      itemWarning: "",
      itemImgUrl:
          "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    );
  }

  @override
  String toString() {
    return 'Item{sku: $sku, businessId: $businessId, category: $category, name: $name, stockAmount: $stockAmount, ordersAmount: $ordersAmount}';
  }
}
