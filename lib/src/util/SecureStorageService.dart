import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create storage
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final storage = const FlutterSecureStorage();

  // final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);
  // await storage.write(key: key, value: value, iOptions: options);

  // Read value
  Future<String?> get(String key) async {
    String? value =
        await storage.read(key: key, aOptions: _getAndroidOptions());
    return value;
  }

  // Read all values
  Future<Map<String, String>> getAll() async {
    Map<String, String> allValues =
        await storage.readAll(aOptions: _getAndroidOptions());
    return allValues;
  }

  // Delete value
  delete(String key) async {
    await storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  // Delete all
  deleteAll() async {
    await storage.deleteAll(aOptions: _getAndroidOptions());
  }

  // Write value
  write(String key, String value) async {
    await storage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }
}
