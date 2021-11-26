import '../../data/data.dart';
import '../../domain/domain.dart';

class GetProductsComposite implements GetProducts {
  final RemoteGetProducts _remoteGetProducts;
  final LocalSaveProducts _localSaveProducts;
  final LocalGetProducts _localGetProducts;

  const GetProductsComposite(
    this._remoteGetProducts,
    this._localSaveProducts,
    this._localGetProducts,
  );

  @override
  Future<List<Product>> getProducts() async {
    try {
      final products = await _remoteGetProducts.getProducts();
      await _localSaveProducts.saveProducts(products);
      return products;
    } catch (error) {
      final products = await _localGetProducts.getProducts();
      return products;
    }
  }
}
