import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockCacheStorage extends Mock implements CacheStorage {}

class _MockBox extends Mock implements Box {}

CacheStorage get mockCacheStorage => _MockCacheStorage();
Box get mockBox => _MockBox();

When mockCacheStorageGetCall(
        {required String key, required CacheStorage cacheStorage}) =>
    when(() => cacheStorage.get(key: key));

When mockCacheStorageSaveCall(
        {required String key,
        required Map<String, dynamic> value,
        required CacheStorage cacheStorage}) =>
    when(() => cacheStorage.save(key: key, value: value));

Future<void> mockCacheStorageGetResponse(
        {required String key,
        required String jsonPath,
        required CacheStorage cacheStorage}) async =>
    mockCacheStorageGetCall(key: key, cacheStorage: cacheStorage)
        .thenAnswer((_) async => jsonToMap(jsonPath));

Future<void> mockCacheStorageSaveResponse(
        {required String key,
        required Map<String, dynamic> value,
        required CacheStorage cacheStorage}) async =>
    mockCacheStorageSaveCall(key: key, cacheStorage: cacheStorage, value: value)
        .thenAnswer((_) => Future.value());

void mockCacheStorageGetError(
        {required String key, required CacheStorage cacheStorage}) =>
    mockCacheStorageGetCall(key: key, cacheStorage: cacheStorage)
        .thenThrow(const ServerError());

void mockCacheStorageSaveError(
        {required String key,
        required CacheStorage cacheStorage,
        required Map<String, dynamic> value}) =>
    mockCacheStorageSaveCall(key: key, cacheStorage: cacheStorage, value: value)
        .thenThrow(const ServerError());

When mockBoxGetCall({required Box box, required String key}) =>
    when(() => box.get(key));

void mockBoxGetResponse(
        {required Box box, required String key, required dynamic response}) =>
    mockBoxGetCall(box: box, key: key).thenAnswer((_) async => response);

void mockBoxGetError({required Box box, required String key}) =>
    mockBoxGetCall(box: box, key: key).thenThrow(Exception());

When mockBoxPutCall(
        {required Box box,
        required String key,
        required Map<String, dynamic> value}) =>
    when(() => box.put(key, jsonEncode(value)));

void mockBoxPutResponse(
        {required Box box,
        required String key,
        required Map<String, dynamic> value}) =>
    mockBoxPutCall(box: box, key: key, value: value)
        .thenAnswer((_) => Future.value());

void mockBoxPutError(
        {required Box box,
        required String key,
        required Map<String, dynamic> value}) =>
    mockBoxPutCall(box: box, key: key, value: value).thenThrow(Exception());
