import 'package:injectable/injectable.dart';
import 'package:puzzle_app/routes/app_router.dart';

@injectable
class PuzzleNavigator {
  const PuzzleNavigator(this._router);

  final AppRouter _router;

  Future<void> endGame(
    String time,
    int steps,
  ) =>
      _router.push(
        CongratulationRoute(duration: time, steps: steps),
      );

  Future<bool> pop() => _router.pop();
}
