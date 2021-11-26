import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockGetProducts extends Mock implements GetProducts {}

class _MockRemoteGetProducts extends Mock implements RemoteGetProducts {}

class _MockLocalGetProducts extends Mock implements LocalGetProducts {}

class _MockLocalSaveProducts extends Mock implements LocalSaveProducts {}

GetProducts get mockGetProducts => _MockGetProducts();
RemoteGetProducts get mockRemoteGetProducts => _MockRemoteGetProducts();
LocalGetProducts get mockLocalGetProducts => _MockLocalGetProducts();
LocalSaveProducts get mockLocalSaveProducts => _MockLocalSaveProducts();

When mockGetProductsCall(GetProducts getProducts) =>
    when(() => getProducts.getProducts());

When mockSaveProductsCall(SaveProducts saveProducts) =>
    when(() => saveProducts.saveProducts([baseProduct]));

When mockGetLocalProductsCall(GetProducts getProducts) =>
    when(() => getProducts.getProducts());

void mockGetProductsResponse(GetProducts getProducts,
        {List<Product>? response}) =>
    mockGetProductsCall(getProducts)
        .thenAnswer((_) async => response ?? [baseProduct]);

void mockSaveProductsResponse(SaveProducts saveProducts,
        {List<Product>? response}) =>
    mockSaveProductsCall(saveProducts)
        .thenAnswer((_) async => response ?? [baseProduct]);

void mockGetLocalProductsResponse(GetProducts getProducts,
        {List<Product>? response}) =>
    mockGetLocalProductsCall(getProducts)
        .thenAnswer((_) async => response ?? [baseProduct]);

void mockGetProductsError(
        {required GetProducts getProducts, required Exception exception}) =>
    mockGetProductsCall(getProducts).thenThrow(exception);
