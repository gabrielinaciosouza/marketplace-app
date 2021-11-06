import 'package:intl/intl.dart';

import '../../../../domain/domain.dart';

class ProductViewModel {
  final String productName;
  final String price;
  final String imageUrl;

  const ProductViewModel({
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  factory ProductViewModel.fromEntity(Product product) {
    final format = NumberFormat.simpleCurrency(locale: 'pt-br');
    return ProductViewModel(
      productName: product.productName,
      price: format.format(product.price),
      imageUrl: product.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ProductViewModel &&
      other.runtimeType == runtimeType &&
      other.productName == productName &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => productName.hashCode;
}
