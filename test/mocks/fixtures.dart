import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/ui/ui.dart';

Product get baseProduct => const Product(
    id: "1",
    productName: "Iphone 11",
    price: 5999.99,
    imageUrl:
        "https://a-static.mlcdn.com.br/618x463/iphone-11-apple-64gb-preto-61-12mp-ios/magazineluiza/155610500/2815c001fcdff11766fcb266dca62daf.jpg");

ProductViewModel get baseProductViewModel =>
    ProductViewModel.fromEntity(baseProduct);
