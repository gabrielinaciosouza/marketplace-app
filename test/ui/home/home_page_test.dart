import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/ui/ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/test_helpers.dart';
import '../../mocks/mocks.dart';

class MockHomePresenter extends Mock implements HomePresenter {}

void main() {
  late MockHomePresenter homePresenter;
  late StreamController<bool> isLoadingController;
  late StreamController<List<ProductViewModel>> productsController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    productsController = StreamController<List<ProductViewModel>>.broadcast();
  }

  void mockStreams() {
    when(() => homePresenter.isLoading)
        .thenAnswer((_) => isLoadingController.stream);
    when(() => homePresenter.productsStream)
        .thenAnswer((_) => productsController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    productsController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    homePresenter = MockHomePresenter();

    initStreams();
    mockStreams();
    final homePage = buildApp(HomePage(
      homePresenter,
    ));

    await mockNetworkImages(() async => tester.pumpWidget(homePage));
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call loadProducts on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => homePresenter.loadProducts()).called(1);
  });

  testWidgets('Should render all components', (WidgetTester tester) async {
    await loadPage(tester);
    productsController.add([baseProductViewModel]);
    await tester.pump();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text && widget.data == R.strings.appBarHomePageTitle),
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
            widget is ProductCard && widget.product == baseProductViewModel),
        findsOneWidget);
    expect(find.text(baseProductViewModel.price), findsOneWidget);
    expect(find.text(baseProductViewModel.name), findsOneWidget);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error if loadProduct throw serverError',
      (WidgetTester tester) async {
    await loadPage(tester);

    productsController.addError(R.strings.serverErrorMessage);
    await tester.pump();

    expect(find.byType(RetryErrorMessage), findsOneWidget);
    expect(find.text(R.strings.serverErrorMessage), findsOneWidget);
  });

  testWidgets('Should call loadProducts on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    productsController.addError(R.strings.serverErrorMessage);
    await tester.pump();
    await tester.tap(find.byType(RetryButton));

    verify(() => homePresenter.loadProducts()).called(2);
  });

  testWidgets('Should render empty list message', (WidgetTester tester) async {
    await loadPage(tester);

    productsController.add([]);
    await tester.pump();

    expect(find.byType(EmptyListMessage), findsOneWidget);
    expect(find.text(R.strings.emptyList), findsOneWidget);
  });

  testWidgets('Should scroll product list', (WidgetTester tester) async {
    await loadPage(tester);

    productsController.add(
      List.generate(
        4,
        (index) => ProductViewModel(
            name: index.toString(),
            price: baseProductViewModel.price,
            imageUrl: baseProductViewModel.imageUrl),
      ),
    );

    await tester.pump();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is ProductCard && widget.product.name == '0'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is ProductCard && widget.product.name == '3'),
        findsNothing);

    await tester.drag(
        find.byWidgetPredicate(
            (widget) => widget is ProductCard && widget.product.name == '0'),
        const Offset(-500, 0));

    await tester.pump();

    expect(
        find.byWidgetPredicate(
            (widget) => widget is ProductCard && widget.product.name == '3'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is ProductCard && widget.product.name == '0'),
        findsNothing);
  });
}
