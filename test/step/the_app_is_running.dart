import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_app/di/injection.dart' as di;
import 'package:puzzle_app/main.dart';

import '../util/mock_common_finctions.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await di.getIt.reset();
  di.configureDependencies();
  await tester.pumpWidget(
    const MyApp(
      locale: Locale('en'),
    ),
  );
  di.getIt
    ..allowReassignment = true
    ..registerSingleton(getCommonFunctions())
    ..allowReassignment = false;

  await tester.pumpAndSettle();
}
