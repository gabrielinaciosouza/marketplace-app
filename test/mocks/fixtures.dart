import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';

const baseProduct = Product(
    id: "1",
    name: "Iphone 11",
    price: 5999.99,
    imageUrl:
        "https://a-static.mlcdn.com.br/618x463/iphone-11-apple-64gb-preto-61-12mp-ios/magazineluiza/155610500/2815c001fcdff11766fcb266dca62daf.jpg",
    categoryId: '2');

final baseProductViewModel = ProductViewModel.fromEntity(baseProduct);

final baseProductData = ProductData.fromEntity(baseProduct);

const baseCategory =
    Category(id: '619fdf2bfc0033173bd89206', name: 'Camisetas Masculinas');

final baseCategoryData = CategoryData.fromEntity(baseCategory);

const baseHome = Home(products: [baseProduct], categories: [baseCategory]);
