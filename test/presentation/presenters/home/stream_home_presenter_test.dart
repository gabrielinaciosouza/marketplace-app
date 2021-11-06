import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:marketplace_app/ui/ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

class MockGetProducts extends Mock implements GetProducts {}

void main() {
  late StreamHomePresenter sut;
  late GetProducts getProducts;

  setUp(() {
    getProducts = MockGetProducts();
    sut = StreamHomePresenter(getProducts);
  });

  tearDown(() {
    sut.dispose();
  });
  test(
    'Should call loadProducts',
    () {
      mockGetProductsResponse(getProducts);
      sut.loadProducts();
      verify(() => getProducts.getProducts());
    },
  );

  test(
    'Should emit server message error if loadProducts return serverError',
    () {
      mockGetProductsError(
          getProducts: getProducts, exception: const ServerError());

      expectLater(sut.isLoading, emitsInOrder([true, false]));
      sut.controller.stream.listen(
        null,
        onError: expectAsync1(
          (error) => expect(error, R.strings.serverErrorMessage),
        ),
      );

      sut.loadProducts();
    },
  );

  test(
    'Should emit a list of products on success',
    () async {
      mockGetProductsResponse(getProducts);

      expectLater(sut.isLoading, emitsInOrder([true, false]));
      expectLater(
        sut.productsStream,
        emitsInOrder(
          [
            [],
            [baseProductViewModel]
          ],
        ),
      );

      sut.loadProducts();
    },
  );

  test(
    'Should close controller after dispose',
    () async {
      mockGetProductsResponse(getProducts);
      expectLater(sut.isLoading, neverEmits(false));

      sut.dispose();
      sut.loadProducts();
    },
  );

  test(
    'Should close controller after dispose onError',
    () async {
      mockGetProductsError(
          getProducts: getProducts, exception: const ServerError());
      expectLater(sut.isLoading, neverEmits(false));

      sut.dispose();
      sut.loadProducts();
    },
  );
}
