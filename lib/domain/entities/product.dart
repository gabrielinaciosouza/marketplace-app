class Product {
  final String id;
  final String productName;
  final double price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      other is Product &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.productName == productName &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => id.hashCode;
}
