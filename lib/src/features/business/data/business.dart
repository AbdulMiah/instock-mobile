import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Business {
  final String name;
  final String? businessId;
  final String description;
  final String owner;
  final File? logo;

  const Business({
    required this.name,
    this.businessId,
    required this.description,
    required this.owner,
    this.logo
  });

  factory Business.fromJson(Map<String, dynamic> json, File logoImg) {
    return Business(
      name: json['Name'],
      businessId: json['BusinessId'],
      description: json['Description'],
      owner: json['Owner'],
      logo: logoImg,
    );
  }

  @override
  String toString() {
    return 'Business{name: $name, businessId: $businessId, description: $description, owner: $owner}';
  }

  // Taken from https://mrgulshanyadav.medium.com/convert-image-url-to-file-format-in-flutter-10421bccfd18
  static Future<File> fileFromImageUrl(String imageUrl) async {
    var rand = Random();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    File file = File('$tempPath${rand.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}
