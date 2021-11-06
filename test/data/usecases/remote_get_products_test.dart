import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late HttpClient httpClient;
  late String url;
  late RemoteGetProducts sut;

  setUp(() async {
    httpClient = mockHttpClient;
    url = faker.internet.httpsUrl();
    sut = RemoteGetProducts(httpClient, url: url);
    await mockHttpClientGetResponse(
        url: url, jsonPath: productResponsePath, httpClient: httpClient);
  });

  test('Should call HttpClient.get with correct values', () async {
    await sut.getProducts();

    verify(() => httpClient.get(url: url)).called(1);
  });

  test('Should throw if HttpClient throws', () {
    mockHttpClientGetError(httpClient: httpClient, url: url);

    final future = sut.getProducts();

    expect(future, throwsA(const ServerError()));
  });

  test('Should throw if HttpClient returns null', () {
    mockHttpClientGetCall(url: url, httpClient: httpClient)
        .thenAnswer((_) => null);

    final future = sut.getProducts();

    expect(future, throwsA(const ServerError()));
  });

  test('Shoud return products on success', () async {
    final products = await sut.getProducts();

    expect(products, [baseProduct]);
  });
}
