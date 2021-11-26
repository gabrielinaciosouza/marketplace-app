import 'package:equatable/equatable.dart';

import '../../../../domain/domain.dart';

class CategoryViewModel with EquatableMixin {
  final String name;

  const CategoryViewModel({
    required this.name,
  });

  factory CategoryViewModel.fromEntity(Category category) {
    return CategoryViewModel(name: category.name);
  }

  @override
  List<Object?> get props => [name];
}
