import 'dart:convert';

import 'package:http/http.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class _MockHttpAdapter extends Mock implements HttpClient {}

class _MockHttp extends Mock implements Client {}

HttpClient get mockHttpClient => _MockHttpAdapter();

Client get mockClient => _MockHttp();

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

When mockClientGetCall(
        {required Client client,
        required String url,
        required Map<String, String> headers}) =>
    when(() => client.get(Uri.parse(url), headers: headers));

void mockClientGetResponse(
        {required Client client,
        required String url,
        required Map<String, String> headers,
        required Map<String, dynamic>? response,
        required int statusCode}) =>
    mockClientGetCall(client: client, url: url, headers: headers)
        .thenAnswer((_) async => Response(jsonEncode(response), statusCode));

void mockClientGetError(
        {required Client client,
        required String url,
        required Map<String, String> headers,
        required Exception exception}) =>
    mockClientGetCall(client: client, url: url, headers: headers)
        .thenThrow(exception);
