class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      other is Product &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.name == name &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => id.hashCode;
}
