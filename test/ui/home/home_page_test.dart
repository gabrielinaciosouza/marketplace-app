import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/test_helpers.dart';
import '../../mocks/mocks.dart';

void main() {
  late HomeCubit homeCubit;
  late GetProducts getProducts;

  setUp(() {
    getProducts = mockGetProducts;
    homeCubit = HomeCubit(getProducts);
    mockGetProductsResponse(getProducts);
  });

  Future<void> loadPage(WidgetTester tester) async => tester.pumpWidget(
        buildApp(
          HomePage(homeCubit),
        ),
      );

  testWidgets(
    'Should call loadProducts on page load',
    (WidgetTester tester) async {
      await mockNetworkImages(
        () async {
          await loadPage(tester);

          verify(() => getProducts.getProducts()).called(1);
        },
      );
    },
  );

  testWidgets(
    'Should render all components',
    (WidgetTester tester) async {
      await mockNetworkImages(
        () async {
          await loadPage(tester);
          await tester.pump();

          expect(
              find.byWidgetPredicate((widget) =>
                  widget is Text &&
                  widget.data == R.strings.appBarHomePageTitle),
              findsOneWidget);
          expect(find.byIcon(Icons.search), findsOneWidget);
          expect(find.byIcon(Icons.menu), findsOneWidget);
          expect(find.byType(ProductList), findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is ProductCardImage &&
                  widget.imageUrl == baseProductViewModel.imageUrl),
              findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is ProductCard &&
                  widget.product == baseProductViewModel),
              findsOneWidget);
          expect(find.text(baseProductViewModel.price), findsOneWidget);
          expect(find.text(baseProductViewModel.name), findsOneWidget);
        },
      );
    },
  );

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await loadPage(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  testWidgets('Should present error if GetProducts throw serverError',
      (WidgetTester tester) async {
    mockGetProductsError(getProducts: getProducts, exception: Exception());

    await loadPage(tester);
    await tester.pump();

    expect(find.byType(RetryErrorMessage), findsOneWidget);
    expect(find.text(R.strings.retryErrorMessage), findsOneWidget);
  });

  testWidgets('Should call loadProducts on reload button click',
      (WidgetTester tester) async {
    mockGetProductsError(getProducts: getProducts, exception: Exception());
    await loadPage(tester);

    await tester.pump();
    await tester.tap(find.byType(RetryButton));

    verify(() => getProducts.getProducts()).called(2);
  });

  testWidgets('Should render empty list message', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      mockGetProductsResponse(getProducts, response: []);
      await loadPage(tester);

      await tester.pump();

      expect(find.byType(EmptyListMessage), findsOneWidget);
      expect(find.text(R.strings.emptyList), findsOneWidget);
    });
  });

  testWidgets(
    'Should scroll product list',
    (WidgetTester tester) async {
      await mockNetworkImages(() async {
        mockGetProductsResponse(
          getProducts,
          response: List.generate(
            4,
            (index) => Product(
                id: faker.guid.guid(),
                name: index.toString(),
                price: baseProduct.price,
                imageUrl: baseProduct.imageUrl),
          ),
        );
        await loadPage(tester);

        await tester.pump();

        expect(
            find.byWidgetPredicate((widget) =>
                widget is ProductCard && widget.product.name == '0'),
            findsOneWidget);
        expect(
            find.byWidgetPredicate((widget) =>
                widget is ProductCard && widget.product.name == '3'),
            findsNothing);

        await tester.drag(
            find.byWidgetPredicate((widget) =>
                widget is ProductCard && widget.product.name == '0'),
            const Offset(-500, 0));

        await tester.pump();

        expect(
            find.byWidgetPredicate((widget) =>
                widget is ProductCard && widget.product.name == '3'),
            findsOneWidget);
        expect(
            find.byWidgetPredicate((widget) =>
                widget is ProductCard && widget.product.name == '0'),
            findsNothing);
      });
    },
  );
}
