import '../../domain.dart';

abstract class SaveProducts {
  Future<void> saveProducts(List<Product> products);
}
