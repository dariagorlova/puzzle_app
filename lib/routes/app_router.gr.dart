// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CongratulationRoute.name: (routeData) {
      final args = routeData.argsAs<CongratulationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CongratulationScreen(
          duration: args.duration,
          key: args.key,
          steps: args.steps,
        ),
      );
    },
    GameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GameScreen(),
      );
    },
  };
}

/// generated route for
/// [CongratulationScreen]
class CongratulationRoute extends PageRouteInfo<CongratulationRouteArgs> {
  CongratulationRoute({
    required String duration,
    Key? key,
    required int steps,
    List<PageRouteInfo>? children,
  }) : super(
          CongratulationRoute.name,
          args: CongratulationRouteArgs(
            duration: duration,
            key: key,
            steps: steps,
          ),
          initialChildren: children,
        );

  static const String name = 'CongratulationRoute';

  static const PageInfo<CongratulationRouteArgs> page =
      PageInfo<CongratulationRouteArgs>(name);
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

/// generated route for
/// [GameScreen]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute({List<PageRouteInfo>? children})
      : super(
          GameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
