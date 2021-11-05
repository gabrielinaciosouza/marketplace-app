import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_utils.dart';

class MockHttpAdapter extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient.get with correct values', () async {
    final httpClient = MockHttpAdapter();
    final url = faker.internet.httpUrl();
    final sut = RemoteGetProducts(httpClient, url: url);
    when(() => httpClient.get(url: url))
        .thenAnswer((invocation) => jsonToMap('product_response.json'));

    await sut.getProducts();

    verify(() => httpClient.get(url: url)).called(1);
  });
}
