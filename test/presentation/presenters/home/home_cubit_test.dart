import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetHome getHome;
  late GetProductsByCategoryId getProductsByCategoryId;
  late HomeState state;
  late CategoryViewModel baseCategoryViewModelWithProducts;

  setUp(() {
    baseCategoryViewModelWithProducts =
        baseCategoryViewModel.copyWith(products: [baseProductViewModel]);
    getProductsByCategoryId = mockGetProductsByCategoryId;
    getHome = mockRemoteGetHome;
    state = HomeState.initialState();
    mockGetHomeResponse(getHome);
    mockGetProductsByCategoryIdResponse(getProductsByCategoryId,
        id: otherCategoryViewModel.id);
  });

  group('loadProducts', () {
    blocTest<HomeCubit, HomeState>(
      'Should call GetHome Usecase and return correct values',
      build: () => HomeCubit(getHome, getProductsByCategoryId),
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        state.copyWith(isLoading: true),
        state.copyWith(
            isLoading: false,
            categories: [baseCategoryViewModelWithProducts],
            selectedCategory: baseCategoryViewModelWithProducts),
      ],
      verify: (_) {
        verify(() => getHome.getHome()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'Should emit correct values if category list is empty',
      build: () {
        mockGetHomeResponse(getHome,
            response: const Home(products: [], categories: []));
        return HomeCubit(getHome, getProductsByCategoryId);
      },
      act: (cubit) => cubit.loadProducts(),
      seed: () => state.copyWith(selectedCategory: otherCategoryViewModel),
      expect: () => [
        state.copyWith(
          isLoading: true,
        ),
        state.copyWith(isLoading: false),
      ],
      verify: (_) {
        verify(() => getHome.getHome()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'Should emit PresentationError if GetProducts throws',
      build: () {
        mockGetHomeError(getHome);
        return HomeCubit(getHome, getProductsByCategoryId);
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
        verify(() => getHome.getHome()).called(1);
      },
    );
  });

  group(
    'selectCategory',
    () {
      blocTest<HomeCubit, HomeState>(
        'Should not select category if event category equals state category',
        build: () => HomeCubit(getHome, getProductsByCategoryId),
        act: (cubit) => cubit.selectCategory(baseCategoryViewModel),
        seed: () => state.copyWith(selectedCategory: baseCategoryViewModel),
        expect: () => [],
      );

      blocTest<HomeCubit, HomeState>(
        'Should not call Usecase if product list is not empty',
        build: () => HomeCubit(getHome, getProductsByCategoryId),
        act: (cubit) => cubit.selectCategory(baseCategoryViewModelWithProducts),
        expect: () => [
          state.copyWith(selectedCategory: baseCategoryViewModelWithProducts)
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'Should select category',
        build: () => HomeCubit(getHome, getProductsByCategoryId),
        act: (cubit) => cubit.selectCategory(otherCategoryViewModel),
        seed: () => state.copyWith(
            selectedCategory: baseCategoryViewModel,
            categories: [baseCategoryViewModel, otherCategoryViewModel]),
        expect: () => [
          state.copyWith(
              isLoadingProductsByCategoryId: true,
              selectedCategory: baseCategoryViewModel,
              categories: [baseCategoryViewModel, otherCategoryViewModel]),
          state.copyWith(
            isLoadingProductsByCategoryId: false,
            categories: [
              baseCategoryViewModel,
              otherCategoryViewModel.copyWith(products: [baseProductViewModel])
            ],
            selectedCategory: otherCategoryViewModel.copyWith(
              products: [baseProductViewModel],
            ),
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'Should emit PresentationError if GetProductsByCategoryId throws',
        build: () {
          mockGetProductsByCategoryIdError(
              getProductsByCategoryId: getProductsByCategoryId,
              id: otherCategoryViewModel.id);
          return HomeCubit(getHome, getProductsByCategoryId);
        },
        act: (cubit) => cubit.selectCategory(otherCategoryViewModel),
        expect: () => [
          state.copyWith(isLoadingProductsByCategoryId: true),
          state.copyWith(
            isLoadingProductsByCategoryId: false,
            presentationError: PresentationError(
              errorOcurred: true,
              message: R.strings.retryErrorMessage,
            ),
          ),
        ],
        verify: (_) {
          verify(() => getProductsByCategoryId
              .getProductsByCategoryId(otherCategoryViewModel.id)).called(1);
        },
      );
    },
  );
}
