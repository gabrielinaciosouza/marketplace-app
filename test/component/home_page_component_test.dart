import 'dart:async';
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/infra/infra.dart';
import 'package:marketplace_app/main/main.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../helpers/test_helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late String url;
  late Client client;
  late Box box;
  late Map<String, dynamic> response;

  setUp(() async {
    url = faker.internet.httpsUrl();
    client = mockClient;
    box = mockBox;
    response = await jsonToMap(homeResponsePath);
  });

  Future<void> loadPage(WidgetTester tester) async {
    final httpClient = HttpAdapter(client);
    final cacheStorage = HiveAdapter(box);

    final remoteGetHome = RemoteGetHome(httpClient, url: url);
    final localSaveProducts = LocalSaveProducts(cacheStorage);
    final localSaveCategories = LocalSaveCategories(cacheStorage);
    final localGetProducts = LocalGetProducts(cacheStorage);
    final localGetCategories = LocalGetCategories(cacheStorage);
    final homeComposite = HomeComposite(remoteGetHome, localSaveProducts,
        localSaveCategories, localGetProducts, localGetCategories);

    final homePage = buildApp(
      HomePage(
        HomeCubit(homeComposite),
      ),
    );

    await tester.pumpWidget(homePage);
  }

  testWidgets('Should load products', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      mockClientGetResponse(
          client: client, response: response, statusCode: 200, url: url);
      mockBoxPutResponse(box: box, key: kProducts, value: {
        kProducts: [baseProductData.toMap()]
      });
      mockBoxPutResponse(box: box, key: kCategories, value: {
        kCategories: [baseCategoryData.toMap()]
      });

      await loadPage(tester);
      await tester.pump();

      expect(
          find.byWidgetPredicate((widget) =>
              widget is ProductCard && widget.product == baseProductViewModel),
          findsOneWidget);
    });
  });

  testWidgets('Should load products from cache', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      mockClientGetResponse(
          client: client, response: response, statusCode: 500, url: url);
      final decodedProduct = await jsonToMap(productResponsePath);
      final decodedCategory = await jsonToMap(categoryResponsePath);

      mockBoxGetResponse(
          box: box, key: kProducts, response: jsonEncode(decodedProduct));
      mockBoxGetResponse(
          box: box, key: kCategories, response: jsonEncode(decodedCategory));

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
    await tester.pump();

    expect(find.byType(RetryErrorMessage), findsOneWidget);
  });
}
