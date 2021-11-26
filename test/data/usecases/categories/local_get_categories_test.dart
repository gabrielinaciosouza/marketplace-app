import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetCategories sut;
  late CacheStorage cacheStorage;

  setUp(() {
    cacheStorage = mockCacheStorage;
    sut = LocalGetCategories(cacheStorage);

    mockCacheStorageGetResponse(
        key: kCategories,
        jsonPath: categoryResponsePath,
        cacheStorage: cacheStorage);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.getCategories();

    verify(() => cacheStorage.get(key: kCategories)).called(1);
  });

  test('Should throw if CacheStorage throws', () {
    mockCacheStorageGetError(cacheStorage: cacheStorage, key: kCategories);

    final future = sut.getCategories();

    expect(future, throwsA(const ServerError()));
  });

  test('Should throw if CacheStorage returns null', () {
    mockCacheStorageGetCall(key: kCategories, cacheStorage: cacheStorage)
        .thenAnswer((_) => null);

    final future = sut.getCategories();

    expect(future, throwsA(const ServerError()));
  });

  test('Shoud return categories on success', () async {
    final categories = await sut.getCategories();

    expect(categories, [baseCategory]);
  });
}
