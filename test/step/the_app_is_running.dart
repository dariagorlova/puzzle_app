import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_app/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(
    const MyApp(
      locale: Locale('en'),
    ),
  );
  await tester.pumpAndSettle();

  //await tester.pumpWidget(MyApp());
}
