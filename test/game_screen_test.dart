// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_see_text.dart';
import './step/i_see_icon.dart';
import './step/i_tap_text.dart';
import './step/i_wait_second.dart';
import './step/i_dont_see_text.dart';
import './step/i_tap_icon.dart';
import './step/i_dont_see.dart';
import './step/i_wait.dart';

void main() {
  group('''Game''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunning(tester);
    }
    testWidgets('''As a User I want to see initial text''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, '1');
      await iSeeText(tester, 'Steps: 0');
      await iSeeText(tester, 'Time: 00:00');
      await iSeeIcon(tester, Icons.replay);
    });
    testWidgets('''As a User I start game and chose wrong number''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, '1');
      await iWaitSecond(tester, 2);
      await iSeeText(tester, 'Steps: 0');
      await iDontSeeText(tester, 'Time: 00:00');
    });
    testWidgets('''As a User I start game and chose right number''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, '14');
      await iWaitSecond(tester, 2);
      await iDontSeeText(tester, 'Steps: 0');
      await iSeeText(tester, 'Steps: 1');
      await iDontSeeText(tester, 'Time: 00:00');
    });
    testWidgets('''As a User I want to restart game''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, '14');
      await iTapIcon(tester, Icons.replay);
      await iDontSee(tester, 'Steps: 1');
      await iSeeText(tester, 'Steps: 0');
    });
    testWidgets('''User Win''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, '14');
      await iWaitSecond(tester, 2);
      await iTapText(tester, '15');
      await iWait(tester);
      await iDontSeeText(tester, '15');
      await iSeeText(tester, 'Congratulation!');
    });
  });
}
