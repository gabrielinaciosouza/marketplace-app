import 'package:equatable/equatable.dart';

import '../../presentation.dart';

class HomeState with EquatableMixin {
  final List<ProductViewModel> products;
  final List<CategoryViewModel> categories;
  final bool isLoading;
  final PresentationError presentationError;

  const HomeState._({
    required this.products,
    required this.categories,
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
    bool? isLoading,
    PresentationError? presentationError,
  }) =>
      HomeState._(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading,
        presentationError: presentationError ?? this.presentationError,
      );

  @override
  List<Object?> get props =>
      [products, categories, isLoading, presentationError];
}
