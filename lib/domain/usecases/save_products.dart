import '../domain.dart';

abstract class SaveProducts {
  Future<void> save(List<Product> products);
}
