import 'dart:io';

class AddNewBusinessDto {
  final String name;
  final String description;
  final File? imageFile;

  const AddNewBusinessDto({
    required this.name,
    required this.description,
    this.imageFile
  });

  Map<String, String> toJson() {
    return {
      'businessName': name,
      'businessDescription': description,
    };
  }
}
