import 'package:equatable/equatable.dart';

class Product with EquatableMixin {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String categoryId;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, name, price, imageUrl, categoryId];
}
