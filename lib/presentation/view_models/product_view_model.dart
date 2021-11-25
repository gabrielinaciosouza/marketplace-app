import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../domain/domain.dart';

class ProductViewModel with EquatableMixin {
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
  List<Object?> get props => [name, price, imageUrl];
}
