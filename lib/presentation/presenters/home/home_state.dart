import 'package:equatable/equatable.dart';

import '../../presentation.dart';

class HomeState with EquatableMixin {
  final List<ProductViewModel> products;
  final List<CategoryViewModel> categories;
  final CategoryViewModel? selectedCategory;
  final bool isLoading;
  final PresentationError presentationError;

  const HomeState._({
    required this.products,
    required this.categories,
    this.selectedCategory,
    required this.isLoading,
    required this.presentationError,
  });

  factory HomeState.initialState() => const HomeState._(
        products: [],
        categories: [],
        isLoading: false,
        presentationError: PresentationError(errorOcurred: false),
      );

  HomeState copyWith({
    List<ProductViewModel>? products,
    List<CategoryViewModel>? categories,
    CategoryViewModel? selectedCategory,
    bool? isLoading,
    PresentationError? presentationError,
  }) =>
      HomeState._(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        isLoading: isLoading ?? this.isLoading,
        presentationError: presentationError ?? this.presentationError,
      );

  @override
  List<Object?> get props =>
      [products, categories, isLoading, presentationError, selectedCategory];
}
