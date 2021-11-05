import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_utils.dart';

class MockHttpAdapter extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late String url;
  late RemoteGetProducts sut;

  const productResponsePath = 'product_response.json';

  setUp(() {
    httpClient = MockHttpAdapter();
    url = faker.internet.httpsUrl();
    sut = RemoteGetProducts(httpClient, url: url);
  });

  When mockHttpClientGetCall() => when(() => httpClient.get(url: url));

  Future<void> mockHttpClientGetResponse(String jsonPath) async =>
      mockHttpClientGetCall().thenAnswer((_) async => jsonToMap(jsonPath));

  void mockHttpClientGetError() =>
      mockHttpClientGetCall().thenThrow(Exception());

  test('Should call HttpClient.get with correct values', () async {
    await mockHttpClientGetResponse(productResponsePath);
    await sut.getProducts();

    verify(() => httpClient.get(url: url)).called(1);
  });

  test('Should throw if HttpClient throws', () {
    mockHttpClientGetError();
    final future = sut.getProducts();

    expect(future, throwsA(isA<Exception>()));
  });
}
