// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_see_text.dart';
import './step/i_see_icon.dart';
import './step/i_tap_text.dart';
import './step/i_dont_see_text.dart';
import './step/i_tap_icon.dart';
import './step/i_dont_see.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theAppIsRunning(tester);
  }
  group('''Start of application''', () {
    testWidgets('''As a User I want to see initial text''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, 'Time: 00:00');
      await iSeeText(tester, 'Steps: 0');
      await iSeeText(tester, '1');
      await iSeeIcon(tester, Icons.repeat);
    });
    testWidgets('''As a User I start game''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, '1');
      await iDontSeeText(tester, 'Steps: 0');
      await iSeeText(tester, 'Steps: 1');
    });
    testWidgets('''As a User I want to restart game''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, '1');
      await iTapIcon(tester, Icons.repeat);
      await iDontSee(tester, 'Steps: 1');
      await iSeeText(tester, 'Steps: 0');
    });
  });
}
