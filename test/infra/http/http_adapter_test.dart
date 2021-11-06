import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:marketplace_app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/http/http.dart';

void main() {
  late HttpAdapter sut;
  late Client client;
  late String url;
  late Map<String, String> headers;
  late Map<String, dynamic> response;

  const int ok = 200;
  const int serverError = 500;

  setUp(() {
    client = mockClient;
    sut = HttpAdapter(client);
    url = faker.internet.httpsUrl();
    headers = {'any_header': 'any_value'};
    response = {'any_key': 'any_value'};

    mockClientGetResponse(
      client: client,
      headers: headers,
      response: response,
      statusCode: ok,
      url: url,
    );
  });

  void mockGetResponse(int statusCode) => mockClientGetResponse(
        client: client,
        headers: headers,
        response: response,
        statusCode: statusCode,
        url: url,
      );

  test('Should call http get with correct values', () async {
    await sut.get(url: url, headers: headers);

    verify(() => client.get(Uri.parse(url), headers: headers)).called(1);
  });

  test('Should return correct values on statusCode 200', () async {
    final result = await sut.get(url: url, headers: headers);

    expect(result, response);
  });

  test('Should return throw HttpServerError on statusCode different from 200',
      () {
    mockGetResponse(serverError);

    final future = sut.get(url: url, headers: headers);

    expect(future, throwsA(const HttpServerError()));
  });

  test('Should throw HttpServerError if Client throws', () {
    mockClientGetError(
        client: client,
        headers: headers,
        url: url,
        exception: const HttpServerError());

    final future = sut.get(url: url, headers: headers);

    expect(future, throwsA(const HttpServerError()));
  });
}
