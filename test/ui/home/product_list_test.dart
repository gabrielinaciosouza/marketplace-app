import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/test_helpers.dart';
import '../../mocks/mocks.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  final cubit = MockHomeCubit();
  Future<void> loadPage(WidgetTester tester) async => tester.pumpWidget(
        buildApp(HomePage(cubit)),
      );
  testWidgets('Should handle loading products by category id correctly',
      (WidgetTester tester) async {
    when(() => cubit.loadProducts()).thenAnswer((_) async => [baseProduct]);
    when(() => cubit.close()).thenAnswer((_) => Future.value());

    await mockNetworkImages(() async {
      final state = HomeState.initialState();

      whenListen(cubit,
          Stream.value(state.copyWith(isLoadingProductsByCategoryId: true)),
          initialState: state);

      await loadPage(tester);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
