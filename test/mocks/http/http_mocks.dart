import 'package:marketplace_app/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

class MockHttpAdapter extends Mock implements HttpClient {}

HttpClient get mockHttpClient => MockHttpAdapter();

When mockHttpClientGetCall(
        {required String url, required HttpClient httpClient}) =>
    when(() => httpClient.get(url: url));

Future<void> mockHttpClientGetResponse(
        {required String url,
        required String jsonPath,
        required HttpClient httpClient}) async =>
    mockHttpClientGetCall(url: url, httpClient: httpClient)
        .thenAnswer((_) async => jsonToMap(jsonPath));

void mockHttpClientGetError(
        {required String url, required HttpClient httpClient}) =>
    mockHttpClientGetCall(url: url, httpClient: httpClient)
        .thenThrow(Exception());
