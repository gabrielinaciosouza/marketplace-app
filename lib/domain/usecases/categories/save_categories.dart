import '../../domain.dart';

abstract class SaveCategories {
  Future<void> saveCategories(List<Category> categories);
}
