import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/test_helpers.dart';
import '../../mocks/mocks.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  late HomeCubit homeCubit;
  late GetHome getHome;
  late GetProductsByCategoryId getProductsByCategoryId;
  late HomeCubit cubit;

  setUp(() {
    cubit = MockHomeCubit();
    getHome = mockRemoteGetHome;
    getProductsByCategoryId = mockGetProductsByCategoryId;
    homeCubit = HomeCubit(getHome, getProductsByCategoryId);
    mockGetHomeResponse(getHome);
    mockGetProductsByCategoryIdResponse(getProductsByCategoryId, id: '1');
  });

  Future<void> loadPage(WidgetTester tester, {HomeCubit? cubit}) async =>
      tester.pumpWidget(
        buildApp(HomePage(cubit ?? homeCubit)),
      );

  testWidgets(
    'Should call loadProducts on page load',
    (WidgetTester tester) async {
      await mockNetworkImages(
        () async {
          await loadPage(tester);

          verify(() => getHome.getHome()).called(1);
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
    mockGetHomeError(getHome);

    await loadPage(tester);
    await tester.pump();

    expect(find.byType(RetryErrorMessage), findsOneWidget);
    expect(find.text(R.strings.retryErrorMessage), findsOneWidget);
  });

  testWidgets('Should call loadProducts on reload button click',
      (WidgetTester tester) async {
    mockGetHomeError(getHome);
    await loadPage(tester);

    await tester.pump();
    await tester.tap(find.byType(RetryButton));

    verify(() => getHome.getHome()).called(2);
  });

  testWidgets('Should render empty list message', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      mockGetHomeResponse(getHome,
          response: const Home(products: [], categories: []));
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
        mockGetHomeResponse(
          getHome,
          response: Home(
              products: List.generate(
                4,
                (index) => Product(
                    id: faker.guid.guid(),
                    name: index.toString(),
                    price: baseProduct.price,
                    imageUrl: baseProduct.imageUrl,
                    categoryId: baseProduct.categoryId),
              ),
              categories: [baseCategory]),
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

  testWidgets(
    'Should scroll category list',
    (WidgetTester tester) async {
      await mockNetworkImages(
        () async {
          mockGetHomeResponse(
            getHome,
            response: Home(
              products: [baseProduct],
              categories: List.generate(
                8,
                (index) => Category(
                  id: faker.guid.guid(),
                  name: index.toString(),
                ),
              ),
            ),
          );
          await loadPage(tester);

          await tester.pump();

          expect(
              find.byWidgetPredicate((widget) =>
                  widget is CategoryItem &&
                  widget.categoryViewModel.name == '0'),
              findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is CategoryItem &&
                  widget.categoryViewModel.name == '7'),
              findsNothing);

          await tester.drag(
              find.byWidgetPredicate((widget) =>
                  widget is CategoryItem &&
                  widget.categoryViewModel.name == '0'),
              const Offset(-500, 0));

          await tester.pump();

          expect(
              find.byWidgetPredicate((widget) =>
                  widget is CategoryItem &&
                  widget.categoryViewModel.name == '7'),
              findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is CategoryItem &&
                  widget.categoryViewModel.name == '0'),
              findsNothing);
        },
      );
    },
  );

  testWidgets(
    'Should select category item',
    (WidgetTester tester) async {
      await mockNetworkImages(
        () async {
          mockGetHomeResponse(getHome,
              response: Home(
                  products: [otherProduct],
                  categories: List.generate(
                    3,
                    (index) => Category(
                      id: index.toString(),
                      name: index.toString(),
                    ),
                  )));
          await loadPage(tester);

          await tester.pump();

          expect(
              find.byWidgetPredicate((widget) =>
                  widget is SelectedCategoryItem && widget.name == '0'),
              findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is ProductCard && widget.product.name == 'Iphone 12'),
              findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is ProductCard && widget.product.name == 'Iphone 11'),
              findsNothing);

          await tester.tap(find.byWidgetPredicate((widget) =>
              widget is CategoryItem && widget.categoryViewModel.name == '1'));

          await tester.pump();

          verify(() => getProductsByCategoryId.getProductsByCategoryId('1'))
              .called(1);

          expect(
              find.byWidgetPredicate((widget) =>
                  widget is SelectedCategoryItem && widget.name == '1'),
              findsOneWidget);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is ProductCard && widget.product.name == 'Iphone 12'),
              findsNothing);
          expect(
              find.byWidgetPredicate((widget) =>
                  widget is ProductCard && widget.product.name == 'Iphone 11'),
              findsOneWidget);
        },
      );
    },
  );

  testWidgets('Should handle loading products by category id correctly',
      (WidgetTester tester) async {
    when(() => cubit.loadProducts()).thenAnswer((_) async => [baseProduct]);
    when(() => cubit.close()).thenAnswer((_) => Future.value());

    await mockNetworkImages(() async {
      final state = HomeState.initialState();

      whenListen(cubit,
          Stream.value(state.copyWith(isLoadingProductsByCategoryId: true)),
          initialState: state);

      await loadPage(tester, cubit: cubit);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
