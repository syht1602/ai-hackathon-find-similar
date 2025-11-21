import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_hackathon_find_similar/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app title is displayed.
    expect(find.text('AI Hackathon - Find Similar Cars'), findsWidgets);
    expect(find.text('This is a demo project for AI workflow in finding similar cars.'), findsOneWidget);
  });
}
