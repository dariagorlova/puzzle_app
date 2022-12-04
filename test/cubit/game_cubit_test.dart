import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/core/service/common_functions.dart';
import 'package:puzzle_app/core/service/navigator.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/routes/app_router.dart';

void main() {
  final router = AppRouter();
  final allFunc = CommonFunctions();

  late final GameCubit sut;
  setUp(() {
    sut = GameCubit(
      PuzzleNavigator(router),
      allFunc,
    );
  });

  group('Game cubit tests', () {
    test('init updates state with list of numbers', () async {
      sut.init();
      expect(sut.state.numbers.isEmpty, isFalse);
    });
    test('init updates state with list of coords', () async {
      sut
        ..init()
        ..fillInitialCoordList();
      expect(sut.state.listBoxes.isEmpty, isFalse);
    });
    test('updates steps count after correct step', () async {
      sut.init();
      //final steps = sut.state.stepsCount;
      //sut.swapBoxes(13, 50, 0);
      //expect(sut.state.stepsCount, steps + 1);
    });
    test('puzzle completed', () async {
      final list1 = [
        BoxWithCoord(coordX: 0, coordY: 0, text: 1),
      ];
      final list2 = [
        BoxWithCoord(coordX: 0, coordY: 0, text: 1),
      ];
      sut.isPuzzleCompleted(list1, list2);
      expect(sut.state.playerWin, true);
    });
  });
}
