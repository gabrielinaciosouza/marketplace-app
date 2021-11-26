import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/domain/domain.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GetHome getHome;
  late HomeState state;

  setUp(() {
    getHome = mockRemoteGetHome;
    state = HomeState.initialState();
    mockGetHomeResponse(getHome);
  });

  blocTest<HomeCubit, HomeState>(
    'Should call GetHome Usecase return and correct values',
    build: () => HomeCubit(getHome),
    act: (cubit) => cubit.loadProducts(),
    expect: () => [
      state.copyWith(isLoading: true),
      state.copyWith(
          isLoading: false,
          products: [baseProductViewModel],
          categories: [baseCategoryViewModel]),
    ],
    verify: (_) {
      verify(() => getHome.getHome()).called(1);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'Should emit PresentationError if GetProducts throws',
    build: () {
      mockGetHomeError(getHome);
      return HomeCubit(getHome);
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
}
