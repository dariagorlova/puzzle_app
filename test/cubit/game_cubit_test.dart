import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle_app/core/service/common_functions.dart';
import 'package:puzzle_app/core/service/navigator.dart';
import 'package:puzzle_app/features/game/cubit/game_cubit.dart';
import 'package:puzzle_app/routes/app_router.dart';

void main() {
  final router = AppRouter();
  final allFunc = CommonFunctions(); // !!! make mock!!!

  late final GameCubit sut;
  setUp(() {
    sut = GameCubit(
      PuzzleNavigator(router),
      allFunc,
    );
  });

  group('Game cubit tests', () {
    test('init updates state with list of numbers', () async {
      // Arrange (Given)
      // Act (When)
      sut.init();
      // Assert (Then)
      expect(sut.state.numbers.isEmpty, isFalse);
    });
  });
}
