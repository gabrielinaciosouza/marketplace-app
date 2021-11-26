import '../../domain.dart';

abstract class GetCategories {
  Future<List<Category>> getCategories();
}
