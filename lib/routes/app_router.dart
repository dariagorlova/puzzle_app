import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/features/congratulation/congratulation_screen.dart';
import 'package:puzzle_app/features/game/game_screen.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: GameRoute.page, initial: true),
        AutoRoute(page: CongratulationRoute.page),
      ];
}
