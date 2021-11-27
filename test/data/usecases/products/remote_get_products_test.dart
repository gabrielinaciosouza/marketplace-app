import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late HttpClient httpClient;
  late String url;
  late String categoryId;
  late RemoteGetProductsByCategoryId sut;

  setUp(() async {
    categoryId = faker.guid.guid();
    httpClient = mockHttpClient;
    url = faker.internet.httpsUrl();
    sut = RemoteGetProductsByCategoryId(httpClient, url: url);
    await mockHttpClientGetResponse(
        url: '$url$categoryId',
        jsonPath: productResponsePath,
        httpClient: httpClient);
  });

  test('Should call HttpClient.get with correct values', () async {
    await sut.getProductsByCategoryId(categoryId);

    verify(() => httpClient.get(url: '$url$categoryId')).called(1);
  });

  test('Should throw if HttpClient throws', () {
    mockHttpClientGetError(httpClient: httpClient, url: '$url$categoryId');

    final future = sut.getProductsByCategoryId(categoryId);

    expect(future, throwsA(const ServerError()));
  });

  test('Should throw if HttpClient returns null', () {
    mockHttpClientGetCall(url: '$url$categoryId', httpClient: httpClient)
        .thenAnswer((_) => null);

    final future = sut.getProductsByCategoryId(categoryId);

    expect(future, throwsA(const ServerError()));
  });

  test('Shoud return products on success', () async {
    final products = await sut.getProductsByCategoryId(categoryId);

    expect(products, [baseProduct]);
  });
}
