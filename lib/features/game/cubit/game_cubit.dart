import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/core/service/common_functions.dart';
import 'package:puzzle_app/core/service/navigator.dart';
import 'package:puzzle_app/features/game/cubit/game_state.dart';

@injectable
class GameCubit extends Cubit<GameState> {
  GameCubit(
    this._router,
    this._func,
  ) : super(
          const GameState(
            stepsCount: 0,
          ),
        ) {
    init();
  }

  final PuzzleNavigator _router;
  final CommonFunctions _func;

  void init() {
    final listNumbers = _func.createNewListOfNumbers();

    emit(
      state.copyWith(
        numbers: listNumbers,
        stepsCount: 0,
        gameHasBegun: false,
        playerWin: false,
        gameStartTimeInMilliSecSinceEpoch: 0,
      ),
    );

    if (!_func.isSolvable(listNumbers)) {
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

  void fillInitialCoordList(
    int startX,
    int boxWidthWithSpace,
  ) {
    final listBoxes = _func.fillInitialCoordList(
      startX,
      boxWidthWithSpace,
      state.numbers,
    );

    emit(state.copyWith(listBoxes: listBoxes));
  }

  void swapBoxes(
    int index,
    int boxWidth,
    int startX,
  ) {
    final listBoxes = List.generate(
      state.listBoxes.length,
      (index) => state.listBoxes.elementAt(index),
    );

    final curNum = listBoxes.elementAt(index).text;

    final curElement =
        listBoxes.firstWhere((element) => element.text == curNum);
    final curElementIndex =
        listBoxes.indexWhere((element) => element == curElement);
    final emptyElement = listBoxes.firstWhere((element) => element.text == 16);
    final emptyIndex =
        listBoxes.indexWhere((element) => element == emptyElement);

    final canSwap = _func.canSwap(listBoxes, index, boxWidth, startX);
    if (canSwap) {
      listBoxes[curElementIndex] = BoxWithCoord(
        coordX: emptyElement.coordX,
        coordY: emptyElement.coordY,
        text: curElement.text,
      );
      listBoxes[emptyIndex] = BoxWithCoord(
        coordX: curElement.coordX,
        coordY: curElement.coordY,
        text: emptyElement.text,
      );

      final s = state.stepsCount as int;
      emit(
        state.copyWith(
          stepsCount: s + 1,
        ),
      );

      final initList = _func.fillInitialCoordListEmpty(
        startX,
        boxWidth,
      );
      final res = isPuzzleCompleted(
        initList,
        listBoxes,
      );
      if (res) {
        // GAME OVER
        fillInitialCoordList(
          startX,
          boxWidth + boxWidth ~/ 5,
        );
        emit(
          state.copyWith(
            playerWin: true,
            stepsCount: 0,
          ),
        );
      } else {
        emit(state.copyWith(listBoxes: listBoxes));
      }
    }
  }

  bool isPuzzleCompleted(
    List<BoxWithCoord> list1,
    List<BoxWithCoord> list2,
  ) {
    final result = _func.isPuzzleCompleted(list1, list2);
    if (result) {
      gameOver();
    }

    return result;
  }

  void gameStart() {
    final startTime = DateTime.now().millisecondsSinceEpoch;

    emit(
      state.copyWith(
        gameHasBegun: true,
        playerWin: false,
        gameStartTimeInMilliSecSinceEpoch: startTime,
      ),
    );
  }

  void gameOver() {
    emit(
      state.copyWith(
        gameHasBegun: false,
        playerWin: true,
      ),
    );

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
    _router.pop();
    restartGameFromScratch();
  }

  void restartGameFromScratch() {
    init();
    fillInitialCoordList(25, 65);
  }

  void restartGame() {
    final oldCoord = state.listBoxes;
    // calculate startX and boxWidth from oldCoord
    final allX = List.generate(
      oldCoord.length,
      (index) => oldCoord.elementAt(index).coordX,
    )..sort();
    final oldStartX = allX.elementAt(0).toInt();
    final boxWidth = (allX.elementAt(4) - allX.elementAt(0)).toInt();

    init();
    fillInitialCoordList(oldStartX, boxWidth);
  }
}
