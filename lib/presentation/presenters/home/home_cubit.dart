import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../presentation.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHome _getHome;
  final GetProductsByCategoryId _getProductsByCategoryId;

  HomeCubit(this._getHome, this._getProductsByCategoryId)
      : super(HomeState.initialState());

  Future<void> loadProducts() async {
    try {
      emit(HomeState.initialState().copyWith(isLoading: true));

      final result = await _getHome.getHome();
      final products = result.products
          .map((product) => ProductViewModel.fromEntity(product))
          .toList();
      final categories = result.categories
          .map((category) => CategoryViewModel.fromEntity(category))
          .toList();

      if (categories.isEmpty) return emit(state.copyWith(isLoading: false));

      final selectedCategoryWithProducts =
          categories.first.copyWith(products: products);

      categories.first = selectedCategoryWithProducts;

      return emit(
        state.copyWith(
          isLoading: false,
          categories: categories,
          selectedCategory: selectedCategoryWithProducts,
        ),
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

  Future<void> selectCategory(CategoryViewModel categoryViewModel) async {
    try {
      if (categoryViewModel == state.selectedCategory) return;
      if (categoryViewModel.products.isNotEmpty) {
        return emit(state.copyWith(selectedCategory: categoryViewModel));
      }

      emit(state.copyWith(isLoadingProductsByCategoryId: true));

      final products = await _getProductsByCategoryId
          .getProductsByCategoryId(categoryViewModel.id);

      final newCategories = [...state.categories];
      final categoryIndex = newCategories
          .indexWhere((category) => category.id == categoryViewModel.id);
      final productViewModelList = products
          .map((product) => ProductViewModel.fromEntity(product))
          .toList();
      final categoryWithProducts =
          categoryViewModel.copyWith(products: productViewModelList);

      newCategories[categoryIndex] = categoryWithProducts;

      emit(
        state.copyWith(
          isLoadingProductsByCategoryId: false,
          categories: newCategories,
          selectedCategory: categoryWithProducts,
        ),
      );
    } catch (error, stacktrace) {
      emit(
        state.copyWith(
          isLoadingProductsByCategoryId: false,
          presentationError: PresentationError(
              errorOcurred: true, message: R.strings.retryErrorMessage),
        ),
      );
      addError(error, stacktrace);
    }
  }
}
