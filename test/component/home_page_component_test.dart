import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/infra/infra.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../helpers/test_helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late String url;
  late Client client;
  late Map<String, dynamic> response;

  setUp(() async {
    url = faker.internet.httpsUrl();
    client = mockClient;
    response = await jsonToMap('product_response.json');
  });

  Future<void> loadPage(WidgetTester tester) async {
    final homePage = buildApp(
      HomePage(
        HomeCubit(
          RemoteGetProducts(HttpAdapter(client), url: url),
        ),
      ),
    );

    await tester.pumpWidget(homePage);
  }

  testWidgets('Should load products', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      mockClientGetResponse(
          client: client, response: response, statusCode: 200, url: url);

      await loadPage(tester);
      await tester.pump();

      expect(
          find.byWidgetPredicate((widget) =>
              widget is ProductCard && widget.product == baseProductViewModel),
          findsOneWidget);
    });
  });

  testWidgets('Should show error', (WidgetTester tester) async {
    mockClientGetResponse(
        client: client, response: response, statusCode: 500, url: url);

    await loadPage(tester);
    await tester.pump(); // starting point of app

    expect(find.byType(RetryErrorMessage), findsOneWidget);
  });
}
