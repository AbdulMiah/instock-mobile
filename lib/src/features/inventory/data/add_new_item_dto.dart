import 'dart:io';

class AddNewItemDto {
  final String sku;
  final String category;
  final String name;
  final String stockAmount;
  final File? imageFile;

  const AddNewItemDto({
    required this.sku,
    required this.category,
    required this.name,
    required this.stockAmount,
    this.imageFile
  });

  Map<String, String> toJson() {
    return {
      'sku': sku,
      'category': category,
      'name': name,
      'stock': stockAmount,
    };
  }
}
