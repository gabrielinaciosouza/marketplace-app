import 'package:intl/intl.dart';

import '../../../../domain/domain.dart';

class ProductViewModel {
  final String name;
  final String price;
  final String imageUrl;

  const ProductViewModel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ProductViewModel.fromEntity(Product product) {
    final format = NumberFormat.simpleCurrency(locale: 'pt-br');
    return ProductViewModel(
      name: product.name,
      price: format.format(product.price),
      imageUrl: product.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ProductViewModel &&
      other.runtimeType == runtimeType &&
      other.name == name &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => name.hashCode;
}
