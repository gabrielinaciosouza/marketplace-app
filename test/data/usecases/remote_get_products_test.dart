import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late HttpClient httpClient;
  late String url;
  late RemoteGetProducts sut;

  setUp(() {
    httpClient = mockHttpClient;
    url = faker.internet.httpsUrl();
    sut = RemoteGetProducts(httpClient, url: url);
  });

  test('Should call HttpClient.get with correct values', () async {
    await mockHttpClientGetResponse(
        url: url, jsonPath: productResponsePath, httpClient: httpClient);
    await sut.getProducts();

    verify(() => httpClient.get(url: url)).called(1);
  });

  test('Should throw if HttpClient throws', () {
    mockHttpClientGetError(httpClient: httpClient, url: url);
    final future = sut.getProducts();

    expect(future, throwsA(isA<Exception>()));
  });

  test('Shoud return products on success', () async {
    await mockHttpClientGetResponse(
        url: url, jsonPath: productResponsePath, httpClient: httpClient);
    final products = await sut.getProducts();

    expect(products, [baseProduct]);
  });
}
