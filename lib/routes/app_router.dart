import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/features/congratulation/congratulation_screen.dart';
import 'package:puzzle_app/features/game/game_screen.dart';

part 'app_router.gr.dart';

@lazySingleton
@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(page: GameScreen, initial: true),
    AutoRoute<bool>(page: CongratulationScreen),
  ],
)
class AppRouter extends _$AppRouter {}
