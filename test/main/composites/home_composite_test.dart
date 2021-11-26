import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/main/main.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/function_mocks/function_mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late HomeComposite sut;
  late RemoteGetHome remoteGetHome;
  late LocalSaveProducts localSaveProducts;
  late LocalSaveCategories localSaveCategories;
  late LocalGetCategories localGetCategories;
  late LocalGetProducts localGetProducts;
  late List<Product> products;
  late List<Category> categories;

  setUp(() {
    remoteGetHome = mockRemoteGetHome;
    localSaveProducts = mockLocalSaveProducts;
    localSaveCategories = mockLocalSaveCategories;
    localGetProducts = mockLocalGetProducts;
    localGetCategories = mockLocalGetCategories;
    sut = HomeComposite(remoteGetHome, localSaveProducts, localSaveCategories,
        localGetProducts, localGetCategories);
    products = [baseProduct];
    categories = [baseCategory];

    mockSaveProductsResponse(localSaveProducts);
    mockGetHomeResponse(remoteGetHome);
    mockSaveCategoriesResponse(localSaveCategories);
    mockGetLocalProductsResponse(localGetProducts);
    mockGetLocalCategoriesResponse(localGetCategories);
  });

  test('Should call RemoteGetHome', () async {
    await sut.getHome();

    verify(() => remoteGetHome.getHome()).called(1);
  });

  test('Should call LocalSaveProducts', () async {
    await sut.getHome();

    verify(() => localSaveProducts.saveProducts(products)).called(1);
  });

  test('Should call LocalSaveCategories', () async {
    await sut.getHome();

    verify(() => localSaveCategories.saveCategories(categories)).called(1);
  });

  test('Should return home on success', () async {
    final home = await sut.getHome();

    expect(home, baseHome);
  });

  test('Should call LocalGetProducts on RemoteGetHomeError', () async {
    mockGetHomeError(remoteGetHome);

    await sut.getHome();

    verify(() => localGetProducts.getProducts()).called(1);
  });

  test('Should call LocalGetCategories on RemoteGetHomeError', () async {
    mockGetHomeError(remoteGetHome);

    await sut.getHome();

    verify(() => localGetProducts.getProducts()).called(1);
  });

  test('Should return home on LocalGetProducts and LocalGetCategories succeeds',
      () async {
    mockGetHomeError(remoteGetHome);

    final home = await sut.getHome();

    expect(home, baseHome);
  });

  test('Should throw if LocalGetProducts throws', () async {
    mockGetHomeError(remoteGetHome);
    mockGetProductsError(getProducts: localGetProducts, exception: Exception());

    final future = sut.getHome();

    expect(future, throwsA(isA<Exception>()));
  });
}
