class AddNewItemDto {
  final String sku;
  final String? businessId;
  final String category;
  final String name;
  final String stockAmount;

  const AddNewItemDto({
    required this.sku,
    this.businessId,
    required this.category,
    required this.name,
    required this.stockAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'businessId': businessId,
      'category': category,
      'name': name,
      'stockAmount': stockAmount,
    };
  }
}
