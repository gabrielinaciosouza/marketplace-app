import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_app/ui/ui.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets(
    'Should render appBar components',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildApp(
          const HomePage(),
        ),
      );

      expect(
          find.byWidgetPredicate((widget) =>
              widget is Text && widget.data == R.strings.appBarHomePageTitle),
          findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    },
  );
}
