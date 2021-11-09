import '../../domain/domain.dart';

class ProductData {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const ProductData({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      );

  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        imageUrl: imageUrl,
      );

  @override
  bool operator ==(Object other) =>
      other is ProductData &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => id.hashCode;
}
