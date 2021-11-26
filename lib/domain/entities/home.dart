import 'package:equatable/equatable.dart';

import '../domain.dart';

class Home with EquatableMixin {
  final List<Product> products;
  final List<Category> categories;

  const Home({
    required this.products,
    required this.categories,
  });

  @override
  List<Object?> get props => [products, categories];
}
