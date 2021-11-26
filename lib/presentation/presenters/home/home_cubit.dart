import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHome _getHome;

  HomeCubit(this._getHome) : super(HomeState.initialState());

  Future<void> loadProducts() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          products: [],
          presentationError: const PresentationError(errorOcurred: false),
        ),
      );

      final result = await _getHome.getHome();
      final products = result.products
          .map((product) => ProductViewModel.fromEntity(product))
          .toList();
      final categories = result.categories
          .map((category) => CategoryViewModel.fromEntity(category))
          .toList();

      emit(state.copyWith(
          isLoading: false, products: products, categories: categories));
    } catch (error, stacktrace) {
      emit(
        state.copyWith(
          isLoading: false,
          presentationError: PresentationError(
              errorOcurred: true, message: R.strings.retryErrorMessage),
        ),
      );
      addError(error, stacktrace);
    }
  }
}
