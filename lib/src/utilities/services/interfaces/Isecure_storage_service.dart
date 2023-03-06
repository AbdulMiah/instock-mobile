abstract class ISecureStorageService {
  Future<String?> get(String key);

  // Read all values
  Future<Map<String, String>> getAll();

  // Delete value
  delete(String key);

  // Delete all
  deleteAll();

  // Write value
  write(String key, String value);
}
