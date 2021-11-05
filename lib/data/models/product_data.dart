import '../../domain/domain.dart';

class ProductData {
  final String id;
  final String productName;
  final double price;
  final String imageUrl;

  const ProductData({
    required this.id,
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json['id'],
        productName: json['productName'],
        price: json['price'],
        imageUrl: json['imageUrl'],
      );

  Product toEntity() => Product(
        id: id,
        productName: productName,
        price: price,
        imageUrl: imageUrl,
      );

  @override
  bool operator ==(Object other) =>
      other is ProductData &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.productName == productName &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => id.hashCode;
}
