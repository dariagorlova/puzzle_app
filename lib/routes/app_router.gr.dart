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
      return MaterialPageX<bool>(
        routeData: routeData,
        child: const CongratulationScreen(),
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
class CongratulationRoute extends PageRouteInfo<void> {
  const CongratulationRoute()
      : super(
          CongratulationRoute.name,
          path: '/congratulation-screen',
        );

  static const String name = 'CongratulationRoute';
}
