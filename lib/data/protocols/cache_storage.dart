abstract class CacheStorage {
  Future<Map<String, dynamic>?> get({required String key});
  Future<void> save({required String key, required Map<String, dynamic> value});
}
