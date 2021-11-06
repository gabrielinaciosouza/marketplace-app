import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

When mockGetProductsCall(GetProducts getProducts) =>
    when(() => getProducts.getProducts());

void mockGetProductsResponse(GetProducts getProducts) =>
    mockGetProductsCall(getProducts).thenAnswer((_) async => [baseProduct]);

void mockGetProductsError(
        {required GetProducts getProducts, required Exception exception}) =>
    mockGetProductsCall(getProducts).thenThrow(exception);
