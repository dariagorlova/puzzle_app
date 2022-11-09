// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    GameRoute.name: (routeData) {
      return MaterialPageX<void>(
        routeData: routeData,
        child: const GameScreen(),
      );
    },
    CongratulationRoute.name: (routeData) {
      final args = routeData.argsAs<CongratulationRouteArgs>();
      return MaterialPageX<bool>(
        routeData: routeData,
        child: CongratulationScreen(
          duration: args.duration,
          key: args.key,
          steps: args.steps,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          GameRoute.name,
          path: '/',
        ),
        RouteConfig(
          CongratulationRoute.name,
          path: '/congratulation-screen',
        ),
      ];
}

/// generated route for
/// [GameScreen]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute()
      : super(
          GameRoute.name,
          path: '/',
        );

  static const String name = 'GameRoute';
}

/// generated route for
/// [CongratulationScreen]
class CongratulationRoute extends PageRouteInfo<CongratulationRouteArgs> {
  CongratulationRoute({
    required String duration,
    Key? key,
    required int steps,
  }) : super(
          CongratulationRoute.name,
          path: '/congratulation-screen',
          args: CongratulationRouteArgs(
            duration: duration,
            key: key,
            steps: steps,
          ),
        );

  static const String name = 'CongratulationRoute';
}

class CongratulationRouteArgs {
  const CongratulationRouteArgs({
    required this.duration,
    this.key,
    required this.steps,
  });

  final String duration;

  final Key? key;

  final int steps;

  @override
  String toString() {
    return 'CongratulationRouteArgs{duration: $duration, key: $key, steps: $steps}';
  }
}
