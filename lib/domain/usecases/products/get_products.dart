import '../../domain.dart';

abstract class GetProducts {
  Future<List<Product>> getProducts();
}
