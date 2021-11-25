import 'dart:convert';

import 'package:hive/hive.dart';

import '../../data/data.dart';

class HiveAdapter implements CacheStorage {
  final Box _box;

  HiveAdapter(this._box);
  @override
  Future<Map<String, dynamic>?> get({required String key}) async {
    final result = await _box.get(key);

    return jsonDecode(result);
  }

  @override
  Future<void> save(
          {required String key, required Map<String, dynamic> value}) async =>
      await _box.put(key, jsonEncode(value));
}
