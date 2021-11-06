import 'dart:async';

import '../../../domain/domain.dart';
import '../../../ui/ui.dart';
import '../../presentation.dart';
import 'home_state.dart';

class StreamHomePresenter with ErrorHandler implements HomePresenter {
  final GetProducts _getProducts;

  StreamHomePresenter(this._getProducts);

  final controller = StreamController<HomeState>.broadcast();
  HomeState _state = HomeState.initialState();

  void _update() {
    try {
      controller.add(_state);
    } catch (error) {
      if (error is StateError) {
        dispose();
      }
    }
  }

  void _addError(DomainException domainException) {
    try {
      controller.addError(handleError(domainException).description);
    } catch (error) {
      if (error is StateError) {
        dispose();
      }
    }
  }

  @override
  Stream<List<ProductViewModel>> get productsStream =>
      controller.stream.map((state) => state.products).distinct();

  @override
  Stream<bool> get isLoading =>
      controller.stream.map((state) => state.isLoading).distinct();

  @override
  void loadProducts() async {
    try {
      _state = _state.copyWith(isLoading: true);
      _update();
      final result = await _getProducts.getProducts();
      final products = result
          .map((product) => ProductViewModel.fromEntity(product))
          .toList();
      _state = _state.copyWith(products: products, isLoading: false);
      _update();
    } on DomainException catch (error) {
      _state = _state.copyWith(isLoading: false);
      _update();
      _addError(error);
    }
  }

  @override
  void dispose() {
    controller.close();
  }
}
