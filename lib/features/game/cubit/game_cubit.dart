import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/core/service/navigator.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';

@injectable
class GameCubit extends Cubit<GameState> {
  GameCubit(
    this._router,
  ) : super(
          const GameState(
            stepsCount: 0,
          ),
        ) {
    init();
  }

  final PuzzleNavigator _router;

  void init() {
    final listNumbers = createNewListOfNumbers();
    final startTime = DateTime.now().millisecondsSinceEpoch;
    emit(
      state.copyWith(
        numbers: listNumbers,
        stepsCount: 0,
        gameHasBegun: false,
        playerWin: false,
        gameStartTimeInMilliSecSinceEpoch: startTime,
      ),
    );

    if (!_isSolvable()) {
      // on start check if shiffles list of numbers can be solvable
      const lastElement = 16;
      var zeroPos = -1;
      for (final element in state.numbers) {
        if (element == lastElement) {
          zeroPos = state.numbers.indexOf(element);
          break;
        }
      }
      final last =
          (zeroPos == lastElement - 1) ? lastElement - 2 : lastElement - 1;
      final previous = (zeroPos == last - 1) ? last - 2 : last - 1;

      // swap last with previous
      final tmpList = List.generate(
        state.numbers.length,
        (index) => state.numbers.elementAt(index),
      );
      final temp = tmpList[last];
      tmpList[last] = tmpList[previous];
      tmpList[previous] = temp;

      emit(state.copyWith(numbers: tmpList));
    }
  }

  List<int> createNewListOfNumbers() {
    return List.generate(
      16,
      (a) => a + 1,
    )..shuffle();
  }

  void gameStart() {
    final startTime = DateTime.now().millisecondsSinceEpoch;

    emit(
      state.copyWith(
        gameHasBegun: true,
        gameStartTimeInMilliSecSinceEpoch: startTime,
      ),
    );
  }

  void gameOver() {
    emit(state.copyWith(gameHasBegun: false, playerWin: true));

    final gameDuration = getGameDuration();
    final steps = state.stepsCount as int;

    _router.endGame(gameDuration, steps);
  }

  String getGameDuration() {
    final startTime = state.gameStartTimeInMilliSecSinceEpoch as int;
    final endTime = DateTime.now().millisecondsSinceEpoch;

    final sec = (endTime - startTime) ~/ 1000; // milliseconds to seconds
    final min = sec ~/ 60;
    final seconds =
        min != 0 ? (sec - min * 60).toString().padLeft(2, '0') : sec.toString();
    final minutes = min != 0 ? (sec ~/ 60).toString().padLeft(2, '0') : '00';

    return '$minutes:$seconds';
  }

  void newGame() {
    init();

    _router.pop();
  }

  void restartGame() {
    init();
    gameStart();
  }

  /////////////////////////
  bool isPuzzleSolved() {
    var res = true;
    state.numbers.asMap().forEach((key, value) {
      if (key + 1 != value) {
        res = false;
      }
    });
    return res;
  }

  bool _isSolvable() {
    var inversions = 0;
    var zeroPos = 0;
    const size = 16;
    final tmpList = List.generate(
      state.numbers.length,
      (index) => state.numbers.elementAt(index),
    );
    for (var i = 0; i < size; i++) {
      final n = tmpList[i];
      if (n == size) {
        zeroPos = i;
      }
      for (var j = i + 1; j < size; j++) {
        final m = tmpList[j];
        if (i != j && m != size && n != size && n > m) {
          inversions++;
        }
      }
    }
    final z = 4 - zeroPos ~/ 4;
    if (z.isEven) {
      return inversions.isOdd;
    }

    return inversions.isEven;
  }

  void swapParts(int curIndex) {
    if (!state.gameHasBegun) {
      gameStart();
    }

    const lastElement = 16;
    //var puzzleData = state.numbers;
    final puzzleData = List.generate(
      state.numbers.length,
      (index) => state.numbers.elementAt(index),
    );
    var swapWith = -1;
    //UP curIndex-matrixSize
    if (curIndex - 4 > -1) {
      if (puzzleData[curIndex - 4] == lastElement) {
        swapWith = curIndex - 4;
      }
    }

    //DOWN curIndex+matrixSize
    if (curIndex + 4 < lastElement) {
      if (puzzleData[curIndex + 4] == lastElement) {
        swapWith = curIndex + 4;
      }
    }

    //LEFT curIndex-1
    if (curIndex - 1 > -1 && (curIndex ~/ 4) == ((curIndex - 1) ~/ 4)) {
      if (puzzleData[curIndex - 1] == lastElement) {
        swapWith = curIndex - 1;
      }
    }

    //RIGHT curIndex+1
    if (curIndex + 1 < lastElement &&
        (curIndex ~/ 4) == ((curIndex + 1) ~/ 4)) {
      if (puzzleData[curIndex + 1] == lastElement) {
        swapWith = curIndex + 1;
      }
    }

    if (swapWith != -1) {
      final temp = puzzleData[curIndex];
      puzzleData[curIndex] = puzzleData[swapWith];
      puzzleData[swapWith] = temp;

      final counts = state.stepsCount as int;
      emit(
        state.copyWith(
          stepsCount: counts + 1,
          numbers: puzzleData,
        ),
      );

      if (isPuzzleSolved()) {
        //gameOver();
        emit(state.copyWith(gameHasBegun: false, playerWin: true));
      }
    }
  }
}
