import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';
import '../data.dart';

class HomeData with EquatableMixin {
  final List<ProductData> products;
  final List<CategoryData> categories;

  const HomeData({
    required this.products,
    required this.categories,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        products: (json[kProducts] as List<dynamic>)
            .map((product) => ProductData.fromJson(product))
            .toList(),
        categories: (json[kCategories] as List<dynamic>)
            .map((category) => CategoryData.fromJson(category))
            .toList(),
      );

  Home toEntity() => Home(
      products: products.map((product) => product.toEntity()).toList(),
      categories: categories.map((category) => category.toEntity()).toList());

  @override
  List<Object?> get props => [products, categories];
}
