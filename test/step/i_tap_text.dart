import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Example: When I tap {'some'} text
Future<void> iTapText(
  WidgetTester tester,
  String text,
) async {
  //await tester.tap(find.text(text));
  //await tester.pump();

  final key = 'box$text';
  await tester.ensureVisible(find.byKey(Key(key)));

  await tester.tap(find.byKey(Key(key)));
  await tester.pumpAndSettle();
}
