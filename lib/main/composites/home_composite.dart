import '../../data/data.dart';
import '../../domain/domain.dart';

class HomeComposite implements GetHome {
  final RemoteGetHome _remoteGetHome;
  final LocalSaveProducts _localSaveProducts;
  final LocalSaveCategories _localSaveCategories;
  final LocalGetProducts _localGetProducts;
  final LocalGetCategories _localGetCategories;

  const HomeComposite(
    this._remoteGetHome,
    this._localSaveProducts,
    this._localSaveCategories,
    this._localGetProducts,
    this._localGetCategories,
  );

  @override
  Future<Home> getHome() async {
    try {
      final home = await _remoteGetHome.getHome();
      await _localSaveProducts.saveProducts(home.products);
      await _localSaveCategories.saveCategories(home.categories);
      return home;
    } catch (error) {
      final products = await _localGetProducts.getProducts();
      final categories = await _localGetCategories.getCategories();
      return Home(products: products, categories: categories);
    }
  }
}
