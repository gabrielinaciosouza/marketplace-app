import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/presentation/presentation.dart';

import '../../../mocks/mocks.dart';

void main() {
  test('Should return correct values on copyWith', () {
    HomeState sut = HomeState.initialState();

    expect(sut.isLoading, isFalse);
    expect(sut.products, isEmpty);

    sut = sut.copyWith(products: [baseProductViewModel], isLoading: null);

    expect(sut.isLoading, isFalse);
    expect(sut.products, [baseProductViewModel]);
  });
}
