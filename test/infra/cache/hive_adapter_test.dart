import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

class MockBox extends Mock implements Box {}

void main() {
  late CacheStorage sut;
  late Box box;
  late String key;
  late String value;
  late String response;

  setUp(() async {
    box = MockBox();
    sut = HiveAdapter(box);
    key = faker.lorem.word();
    value = faker.lorem.word();

    final decodedResponse = await jsonToMap(productResponsePath);
    response = jsonEncode(decodedResponse);

    mockBoxGetResponse(box: box, key: key, response: response);
    mockBoxPutResponse(box: box, key: key, value: value);
  });

  group('GET', () {
    test('Should call get with correct values', () async {
      await sut.get(key: key);

      verify(() => box.get(key)).called(1);
    });

    test('Should return correct values', () async {
      final result = await sut.get(key: key);

      expect(result, jsonDecode(response));
    });

    test('Should throw if box throws', () {
      mockBoxGetError(box: box, key: key);
      final result = sut.get(key: key);

      expect(result, throwsA(isA<Exception>()));
    });
  });

  group('PUT', () {
    test('Should call save with correct values', () async {
      await sut.save(key: key, value: value);

      verify(() => box.put(key, value)).called(1);
    });

    test('Should throw if box throws', () {
      mockBoxPutError(box: box, key: key, value: value);

      final result = sut.save(key: key, value: value);

      expect(result, throwsA(isA<Exception>()));
    });
  });
}
