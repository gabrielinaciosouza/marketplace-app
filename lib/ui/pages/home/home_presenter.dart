import '../../ui.dart';

abstract class HomePresenter {
  Stream<List<ProductViewModel>> get productsStream;
  Stream<bool> get isLoading;
  void loadProducts();
  void dispose();
}
