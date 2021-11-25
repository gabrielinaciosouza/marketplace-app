import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockGetProducts extends Mock implements GetProducts {}

GetProducts get mockGetProducts => _MockGetProducts();

When mockGetProductsCall(GetProducts getProducts) =>
    when(() => getProducts.getProducts());

void mockGetProductsResponse(GetProducts getProducts,
        {List<Product>? response}) =>
    mockGetProductsCall(getProducts)
        .thenAnswer((_) async => response ?? [baseProduct]);

void mockGetProductsError(
        {required GetProducts getProducts, required Exception exception}) =>
    mockGetProductsCall(getProducts).thenThrow(exception);
