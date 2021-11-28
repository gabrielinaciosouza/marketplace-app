import 'package:equatable/equatable.dart';

import '../../presentation.dart';

class HomeState with EquatableMixin {
  final List<CategoryViewModel> categories;
  final CategoryViewModel? selectedCategory;
  final bool isLoading;
  final bool isLoadingProductsByCategoryId;
  final PresentationError presentationError;

  const HomeState._({
    required this.categories,
    this.selectedCategory,
    required this.isLoading,
    required this.isLoadingProductsByCategoryId,
    required this.presentationError,
  });

  factory HomeState.initialState() => const HomeState._(
        categories: [],
        isLoading: false,
        isLoadingProductsByCategoryId: false,
        presentationError: PresentationError(errorOcurred: false),
      );

  HomeState copyWith({
    List<CategoryViewModel>? categories,
    CategoryViewModel? selectedCategory,
    bool? isLoading,
    bool? isLoadingProductsByCategoryId,
    PresentationError? presentationError,
  }) =>
      HomeState._(
        categories: categories ?? this.categories,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        isLoading: isLoading ?? this.isLoading,
        isLoadingProductsByCategoryId:
            isLoadingProductsByCategoryId ?? this.isLoadingProductsByCategoryId,
        presentationError: presentationError ?? this.presentationError,
      );

  @override
  List<Object?> get props => [
        categories,
        isLoading,
        isLoadingProductsByCategoryId,
        presentationError,
        selectedCategory
      ];
}
