import 'dart:io';

class AddNewBusinessDto {
  final String name;
  final String description;
  final File? imageFile;
  String? fcmToken;

  AddNewBusinessDto({
    required this.name,
    required this.description,
    this.imageFile,
    this.fcmToken,
  });

  Map<String, String> toJson() {
    final jsonMap = {
      'businessName': name,
      'businessDescription': description,
    };

    if (fcmToken != null) {
      //The key must be the same as the property name in the controller
      // on the backend
      jsonMap['DeviceKey'] = fcmToken!;
    }

    return jsonMap;
  }
}
