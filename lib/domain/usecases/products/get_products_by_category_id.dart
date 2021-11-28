import '../../domain.dart';

abstract class GetProductsByCategoryId {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}
