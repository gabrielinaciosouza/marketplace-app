import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late HttpClient httpClient;
  late String url;
  late RemoteGetHome sut;

  setUp(() async {
    httpClient = mockHttpClient;
    url = faker.internet.httpsUrl();
    sut = RemoteGetHome(httpClient, url: url);
    await mockHttpClientGetResponse(
        url: url, jsonPath: homeResponsePath, httpClient: httpClient);
  });

  test('Should call HttpClient.get with correct values', () async {
    await sut.getHome();

    verify(() => httpClient.get(url: url)).called(1);
  });

  test('Should throw if HttpClient throws', () {
    mockHttpClientGetError(httpClient: httpClient, url: url);

    final future = sut.getHome();

    expect(future, throwsA(const ServerError()));
  });

  test('Should throw if HttpClient returns null', () {
    mockHttpClientGetCall(url: url, httpClient: httpClient)
        .thenAnswer((_) => null);

    final future = sut.getHome();

    expect(future, throwsA(const ServerError()));
  });

  test('Shoud return home on success', () async {
    final home = await sut.getHome();

    expect(home, baseHome);
  });
}
