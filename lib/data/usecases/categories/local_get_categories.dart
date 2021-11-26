import '../../../domain/domain.dart';
import '../../data.dart';

class LocalGetCategories implements GetCategories {
  final CacheStorage _cacheStorage;

  const LocalGetCategories(this._cacheStorage);
  @override
  Future<List<Category>> getCategories() async {
    try {
      final result = await _cacheStorage.get(key: kCategories);

      final List<dynamic>? categories = result?[kCategories];

      if (categories == null) throw const ServerError();

      return categories
          .map((product) => CategoryData.fromJson(product).toEntity())
          .toList();
    } catch (error) {
      throw const ServerError();
    }
  }
}
