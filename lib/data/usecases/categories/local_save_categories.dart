import '../../../domain/domain.dart';
import '../../data.dart';

class LocalSaveCategories implements SaveCategories {
  final CacheStorage _cacheStorage;

  const LocalSaveCategories(this._cacheStorage);
  @override
  Future<void> saveCategories(List<Category> categories) async {
    try {
      await _cacheStorage.save(
        key: kCategories,
        value: {
          kCategories: categories
              .map((category) => CategoryData.fromEntity(category).toMap())
              .toList()
        },
      );
    } catch (error) {
      throw const ServerError();
    }
  }
}
