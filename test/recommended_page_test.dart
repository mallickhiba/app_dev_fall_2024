import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:iba_course_2/recommended_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testGoldens('RecommendedPage Golden Test', (tester) async {
    await tester.pumpWidgetBuilder(
      const RecommendedPage(),
      wrapper: materialAppWrapper(theme: ThemeData.dark()),
    );
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'ui_sc');
  });
}
