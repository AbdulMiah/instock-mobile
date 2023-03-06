class ISecureStorageService {
  Future<String?> get(String key) {
    return Future<String?>.value();
  }

  // Read all values
  Future<Map<String, String>> getAll() {
    return Future<Map<String, String>>.value();
  }

  // Delete value
  delete(String key) {}

  // Delete all
  deleteAll() {}

  // Write value
  write(String key, String value) {}
}
