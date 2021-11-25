import 'package:equatable/equatable.dart';

import '../../presentation.dart';

class HomeState with EquatableMixin {
  final List<ProductViewModel> products;
  final bool isLoading;
  final PresentationError presentationError;

  const HomeState._({
    required this.products,
    required this.isLoading,
    required this.presentationError,
  });

  factory HomeState.initialState() => const HomeState._(
        products: [],
        isLoading: false,
        presentationError: PresentationError(errorOcurred: false),
      );

  HomeState copyWith({
    List<ProductViewModel>? products,
    bool? isLoading,
    PresentationError? presentationError,
  }) =>
      HomeState._(
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
        presentationError: presentationError ?? this.presentationError,
      );

  @override
  List<Object?> get props => [products, isLoading, presentationError];
}
