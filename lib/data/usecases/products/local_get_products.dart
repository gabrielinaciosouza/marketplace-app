import '../../../domain/domain.dart';
import '../../data.dart';

class LocalGetProducts implements GetProducts {
  final CacheStorage _cacheStorage;

  const LocalGetProducts(this._cacheStorage);
  @override
  Future<List<Product>> getProducts() async {
    try {
      final result = await _cacheStorage.get(key: 'products');

      final List<dynamic>? products = result?['products'];

      if (products == null) throw const ServerError();

      return products
          .map((product) => ProductData.fromJson(product).toEntity())
          .toList();
    } catch (error) {
      throw const ServerError();
    }
  }
}
