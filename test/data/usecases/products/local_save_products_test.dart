import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late CacheStorage cacheStorage;
  late LocalSaveProducts sut;
  late String key;
  late Map<String, dynamic> value;
  late List<Product> products;

  setUp(() async {
    cacheStorage = mockCacheStorage;
    key = kProducts;
    sut = LocalSaveProducts(cacheStorage);
    value = {
      kProducts: [baseProductData.toMap()]
    };
    products = [baseProduct];
    await mockCacheStorageSaveResponse(
        key: key, value: value, cacheStorage: cacheStorage);
  });

  test('Should call CacheStorage.save with correct values', () async {
    await sut.saveProducts(products);

    verify(() => cacheStorage.save(key: key, value: value)).called(1);
  });

  test('Should throw if CacheStorage throws', () {
    mockCacheStorageSaveError(
        cacheStorage: cacheStorage, key: key, value: value);

    final future = sut.saveProducts(products);

    expect(future, throwsA(const ServerError()));
  });
}
