import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockCacheStorage extends Mock implements CacheStorage {}

CacheStorage get mockCacheStorage => _MockCacheStorage();

When mockCacheStorageGetCall(
        {required String key, required CacheStorage cacheStorage}) =>
    when(() => cacheStorage.get(key: key));

Future<void> mockCacheStorageGetResponse(
        {required String key,
        required String jsonPath,
        required CacheStorage cacheStorage}) async =>
    mockCacheStorageGetCall(key: key, cacheStorage: cacheStorage)
        .thenAnswer((_) async => jsonToMap(jsonPath));

void mockCacheStorageGetError(
        {required String key, required CacheStorage cacheStorage}) =>
    mockCacheStorageGetCall(key: key, cacheStorage: cacheStorage)
        .thenThrow(const ServerError());
