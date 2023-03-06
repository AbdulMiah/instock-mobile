import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/utilities/services/interfaces/Isecure_storage_service.dart';

@Injectable(as: ISecureStorageService)
class SecureStorageService implements ISecureStorageService {
  static Future<SecureStorageService> init() async {
    await SecureStorageService.initializeApp();
    return SecureStorageService();
  }

  // Create storage
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final storage = const FlutterSecureStorage();

  // Commented out for now, IOS options for secure storage
  // come back to when testing on IOS
  // final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);
  // await storage.write(key: key, value: value, iOptions: options);

  // Read value
  @override
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
  @override
  void delete(String key) async {
    await storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  // Delete all
  @override
  void deleteAll() async {
    await storage.deleteAll(aOptions: _getAndroidOptions());
  }

  // Write value
  @override
  void write(String key, String value) async {
    await storage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }
}
