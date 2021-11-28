import 'package:equatable/equatable.dart';

import '../../../../domain/domain.dart';
import '../presentation.dart';

class CategoryViewModel with EquatableMixin {
  final String id;
  final String name;
  final List<ProductViewModel> products;

  const CategoryViewModel({
    required this.id,
    required this.name,
    this.products = const [],
  });

  factory CategoryViewModel.fromEntity(Category category) => CategoryViewModel(
        id: category.id,
        name: category.name,
      );

  CategoryViewModel copyWith({
    String? id,
    String? name,
    List<ProductViewModel>? products,
  }) =>
      CategoryViewModel(
        id: id ?? this.id,
        name: name ?? this.name,
        products: products ?? this.products,
      );

  @override
  List<Object?> get props => [name, products];
}
