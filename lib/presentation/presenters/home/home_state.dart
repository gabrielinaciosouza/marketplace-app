import '../../../ui/ui.dart';

class HomeState {
  final List<ProductViewModel> products;
  final bool isLoading;

  HomeState._({
    required this.products,
    required this.isLoading,
  });

  factory HomeState.initialState() => HomeState._(
        products: [],
        isLoading: false,
      );

  HomeState copyWith({
    List<ProductViewModel>? products,
    bool? isLoading,
  }) =>
      HomeState._(
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
      );
}
