import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProducts _getProducts;

  HomeCubit(this._getProducts) : super(HomeState.initialState());

  Future<void> loadProducts() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          products: [],
          presentationError: const PresentationError(errorOcurred: false),
        ),
      );

      final result = await _getProducts.getProducts();
      final products = result
          .map((product) => ProductViewModel.fromEntity(product))
          .toList();

      emit(
        state.copyWith(isLoading: false, products: products),
      );
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
