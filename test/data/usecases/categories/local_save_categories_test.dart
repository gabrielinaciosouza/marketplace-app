import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late SaveCategories sut;
  late CacheStorage cacheStorage;
  late List<Category> categories;
  late Map<String, dynamic> value;

  setUp(() async {
    value = {
      kCategories: [baseCategoryData.toMap()]
    };
    categories = [baseCategory];
    cacheStorage = mockCacheStorage;
    sut = LocalSaveCategories(cacheStorage);

    await mockCacheStorageSaveResponse(
        key: kCategories, value: value, cacheStorage: cacheStorage);
  });

  test('Should call CacheStorage.save with correct values', () async {
    await sut.saveCategories(categories);

    verify(() => cacheStorage.save(key: kCategories, value: value)).called(1);
  });

  test('Should throw if CacheStorage throws', () {
    mockCacheStorageSaveError(
        cacheStorage: cacheStorage, key: kCategories, value: value);

    final future = sut.saveCategories(categories);

    expect(future, throwsA(const ServerError()));
  });
}
