import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/core/service/navigator.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';

@injectable
class GameCubit extends Cubit<GameState> {
  GameCubit(
    this._router,
  ) : super(
          GameState(
            numbers: List.generate(
              15,
              (a) => a + 1,
            ),
            stepsCount: 0,
          ),
        ) {
    init();
  }

  final PuzzleNavigator _router;

  void init() {
    final listNumbers = createNewListOfNumbers();
    emit(state.copyWith(numbers: listNumbers));
  }

  List<int> createNewListOfNumbers() {
    return List.generate(
      15,
      (a) => a + 1,
    )
      ..add(-1)
      ..shuffle();
  }

  void numberPressed(int numberIndex) {
    //final res = canSwapNumber();
    //if (res) {
    //swapNumbers();
    //isGameOver();
    //}

    var numbersList = List.generate(
      state.numbers.length,
      (index) => state.numbers.elementAt(index),
    );
    final numberText = numbersList.elementAt(numberIndex);
    final indexTo = numbersList.indexWhere((element) => element == -1);
    numbersList[indexTo] = numberText;
    numbersList[numberIndex] = -1;

    final counts = state.stepsCount as int;
    emit(state.copyWith(
      stepsCount: counts + 1,
      numbers: numbersList,
    ));
  }

  bool canSwapNumber() {
    return true;
  }

  void isGameOver() {
    // check

    _router.endGame();
  }

  void restartGame() {
    final listNumbers = createNewListOfNumbers();
    emit(state.copyWith(
      stepsCount: 0,
      numbers: listNumbers,
    ));
  }
}
