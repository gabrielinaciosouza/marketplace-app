import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetProducts getProducts;
  late HomeState state;

  setUp(() {
    getProducts = mockGetProducts;
    state = HomeState.initialState();
    mockGetProductsResponse(getProducts);
  });

  blocTest<HomeCubit, HomeState>(
    'Should call GetProducts Usecase and return products',
    build: () => HomeCubit(getProducts),
    act: (cubit) => cubit.loadProducts(),
    expect: () => [
      state.copyWith(isLoading: true),
      state.copyWith(isLoading: false, products: [baseProductViewModel]),
    ],
    verify: (_) {
      verify(() => getProducts.getProducts()).called(1);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'Should emit PresentationError if GetProducts throws',
    build: () {
      mockGetProductsError(getProducts: getProducts, exception: Exception());
      return HomeCubit(getProducts);
    },
    act: (cubit) => cubit.loadProducts(),
    expect: () => [
      state.copyWith(isLoading: true),
      state.copyWith(
        isLoading: false,
        presentationError: PresentationError(
          errorOcurred: true,
          message: R.strings.retryErrorMessage,
        ),
      ),
    ],
    verify: (_) {
      verify(() => getProducts.getProducts()).called(1);
    },
  );
}
