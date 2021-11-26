import '../../../domain/domain.dart';
import '../../data.dart';

class LocalSaveProducts implements SaveProducts {
  final CacheStorage _cacheStorage;

  const LocalSaveProducts(this._cacheStorage);
  @override
  Future<void> save(List<Product> products) async {
    try {
      await _cacheStorage.save(
        key: kProducts,
        value: {
          kProducts: products
              .map((product) => ProductData.fromEntity(product).toMap())
              .toList()
        },
      );
    } catch (error) {
      throw const ServerError();
    }
  }
}
