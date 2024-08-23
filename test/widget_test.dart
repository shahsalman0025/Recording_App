import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recording_app/main.dart';

void main() {
  testWidgets('Check if recording page loads', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify the 'Start Recording' button is present
    expect(find.text(newMethod), findsOneWidget);
  });
}

String get newMethod => 'Start Recording';
