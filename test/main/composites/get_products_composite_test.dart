import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/main/main.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/function_mocks/function_mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late GetProducts sut;
  late RemoteGetProducts remoteGetProducts;
  late LocalGetProducts localGetProducts;
  late LocalSaveProducts localSaveProducts;
  late List<Product> products;

  setUp(() {
    remoteGetProducts = mockRemoteGetProducts;
    localSaveProducts = mockLocalSaveProducts;
    localGetProducts = mockLocalGetProducts;
    sut = GetProductsComposite(
        remoteGetProducts, localSaveProducts, localGetProducts);
    products = [baseProduct];

    mockGetProductsResponse(remoteGetProducts);
    mockSaveProductsResponse(localSaveProducts);
    mockGetLocalProductsResponse(localGetProducts);
  });

  test('Should call RemoteGetProducts', () async {
    await sut.getProducts();

    verify(() => remoteGetProducts.getProducts()).called(1);
  });

  test('Should call LocalSaveProducts', () async {
    await sut.getProducts();

    verify(() => localSaveProducts.saveProducts(products)).called(1);
  });

  test('Should return products on success', () async {
    final products = await sut.getProducts();

    expect(products, [baseProduct]);
  });

  test('Should call LocalGetProducts on RemoteGetProductsError', () async {
    mockGetProductsError(
        getProducts: remoteGetProducts, exception: Exception());
    await sut.getProducts();

    verify(() => localGetProducts.getProducts()).called(1);
  });

  test('Should return products os LocalGetProducts succeeds', () async {
    mockGetProductsError(
        getProducts: remoteGetProducts, exception: Exception());
    final products = await sut.getProducts();

    expect(products, [baseProduct]);
  });

  test('Should throw if LocalGetProducts throws', () async {
    mockGetProductsError(
        getProducts: remoteGetProducts, exception: Exception());
    mockGetProductsError(getProducts: localGetProducts, exception: Exception());

    final future = sut.getProducts();

    expect(future, throwsA(isA<Exception>()));
  });
}
