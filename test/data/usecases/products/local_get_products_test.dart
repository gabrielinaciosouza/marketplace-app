import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late CacheStorage cacheStorage;
  late LocalGetProducts sut;
  late String key;

  setUp(() async {
    cacheStorage = mockCacheStorage;
    key = 'products';
    sut = LocalGetProducts(cacheStorage);
    await mockCacheStorageGetResponse(
        key: key, jsonPath: productResponsePath, cacheStorage: cacheStorage);
  });

  test('Should call CacheStorage.get with correct values', () async {
    await sut.getProducts();

    verify(() => cacheStorage.get(key: key)).called(1);
  });

  test('Should throw if CacheStorage throws', () {
    mockCacheStorageGetError(cacheStorage: cacheStorage, key: key);

    final future = sut.getProducts();

    expect(future, throwsA(const ServerError()));
  });

  test('Should throw if CacheStorage returns null', () {
    mockCacheStorageGetCall(key: key, cacheStorage: cacheStorage)
        .thenAnswer((_) => null);

    final future = sut.getProducts();

    expect(future, throwsA(const ServerError()));
  });

  test('Shoud return products on success', () async {
    final products = await sut.getProducts();

    expect(products, [baseProduct]);
  });
}
