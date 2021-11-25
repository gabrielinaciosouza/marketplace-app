import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

class ProductData with EquatableMixin {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String categoryId;

  const ProductData({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      categoryId: json['categoryId']);

  Product toEntity() => Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      categoryId: categoryId);

  @override
  List<Object?> get props => [id, name, price, imageUrl, categoryId];
}
