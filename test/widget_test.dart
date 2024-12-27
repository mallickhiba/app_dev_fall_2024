// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_course_2/recommended_page.dart';

void main() {
  testWidgets('RecommendedPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RecommendedPage()));

    // Verify the widget tree
    expect(find.text('Recommended for your devices'), findsOneWidget);
    expect(find.text('See All'), findsOneWidget);
    expect(find.text('AirPods Max — Silver'), findsOneWidget);
  });
}
