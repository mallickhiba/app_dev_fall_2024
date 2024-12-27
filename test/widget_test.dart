// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:iba_course_2/recommended_page.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      // await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}

void main() {
  setUpAll(() async {
    await testExecutable(() {});
  });

  testGoldens('RecommendedPage Golden Test', (WidgetTester tester) async {
    var customWidget = const MaterialApp(
      home: Scaffold(
        body: RecommendedPage(),
      ),
    );

    // pump (render)
    await tester.pumpWidgetBuilder(
      customWidget,
      surfaceSize: const Size(400, 800), //adjust based on ur widget
    );

    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Capture the golden screenshot
    await screenMatchesGolden(tester, 'recommended_page');
  });
}
