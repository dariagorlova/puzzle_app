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
          const GameState(),
        ) {
    init();
  }

  final PuzzleNavigator _router;
  final CommonFunctions _func;

  void setBoxSize(double boxSize) {
    emit(
      state.copyWith(
        boxSize: boxSize,
      ),
    );
    fillInitialCoordList();
  }

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

  void boxTaped(int index) {
    if (state.stepsCount == 0) {
      gameStart();
    }
    swapBoxes(index);
  }

  void fillInitialCoordList() {
    final boxWidthWithSpace = state.boxSize + state.boxSize / 5;

    final listBoxes = _func.fillInitialCoordList(
      boxWidthWithSpace,
      state.numbers,
    );

    emit(state.copyWith(listBoxes: listBoxes));
  }

  void swapBoxes(int index) {
    final boxWidth = state.boxSize;
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

    final canSwap = canSwapBoxes(listBoxes, index, boxWidth);
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

      checkForGameOver(listBoxes);
    }
  }

  void checkForGameOver(List<BoxWithCoord> listBoxes) {
    final boxWidthWithSpace =
        state.boxSize + state.boxSize / 5; // ~/5 don't work in web
    final initList = _func.fillInitialCoordList(
      //startX,
      boxWidthWithSpace,
      List<int>.generate(16, (index) => index + 1),
    );
    final res = isPuzzleCompleted(
      initList,
      listBoxes,
    );
    if (res) {
      // GAME OVER
      fillInitialCoordList();
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

  bool isPuzzleCompleted(
    List<BoxWithCoord> list1,
    List<BoxWithCoord> list2,
  ) {
    var result = false;
    for (final box in list2) {
      final elem = list1.firstWhere((element) => element.text == box.text);
      if (box.coordX == elem.coordX && box.coordY == elem.coordY) {
        result = true;
      } else {
        return false;
      }
    }
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
    restartGame();
  }

  void restartGame() {
    init();
    fillInitialCoordList();
  }
}

bool canSwapBoxes(
  List<BoxWithCoord> listBoxes,
  int index,
  double boxWidth,
) {
  final curNum = listBoxes.elementAt(index).text;
  final spaceBetweenBoxes = boxWidth / 5; // ~/

  final curElement = listBoxes.firstWhere((element) => element.text == curNum);
  final coordMidXcur = curElement.coordX + boxWidth / 2;
  final coordMidYcur = curElement.coordY + boxWidth / 2;

  final emptyElement = listBoxes.firstWhere((element) => element.text == 16);
  final coordMidXempty = emptyElement.coordX + boxWidth / 2;
  final coordMidYempty = emptyElement.coordY + boxWidth / 2;

  var canSwap = false;
  final boxWidthAndSpaceBetween = boxWidth + spaceBetweenBoxes;

  // rounded values (need for web)
  final coordMidXcur_ = num.parse(coordMidXcur.toStringAsFixed(1));
  final boxWidthAndSpaceBetween_ =
      num.parse(boxWidthAndSpaceBetween.toStringAsFixed(1));
  final coordMidXempty_ = num.parse(coordMidXempty.toStringAsFixed(1));
  final coordMidYcur_ = num.parse(coordMidYcur.toStringAsFixed(1));
  final coordMidYempty_ = num.parse(coordMidYempty.toStringAsFixed(1));

  final xplusBoxWidth_ = coordMidXcur_ + boxWidthAndSpaceBetween_;
  final yplusBoxWidth_ = coordMidYcur_ + boxWidthAndSpaceBetween_;
  final xminusBoxWidth_ = coordMidXcur_ - boxWidthAndSpaceBetween_;
  final yminusBoxWidth_ = coordMidYcur_ - boxWidthAndSpaceBetween_;
  final xplusBoxWidth = num.parse(xplusBoxWidth_.toStringAsFixed(1));
  final yplusBoxWidth = num.parse(yplusBoxWidth_.toStringAsFixed(1));
  final xminusBoxWidth = num.parse(xminusBoxWidth_.toStringAsFixed(1));
  final yminusBoxWidth = num.parse(yminusBoxWidth_.toStringAsFixed(1));

  // can move current to right
  if (coordMidXempty_.compareTo(xplusBoxWidth) == 0 &&
      coordMidYcur_.compareTo(coordMidYempty_) == 0) {
    canSwap = true;
  }
  // can move current to down
  if (coordMidXcur_.compareTo(coordMidXempty_) == 0 &&
      coordMidYempty_.compareTo(yplusBoxWidth) == 0) {
    canSwap = true;
  }
  // can move current to left
  if (coordMidXempty_.compareTo(xminusBoxWidth) == 0 &&
      coordMidYcur_.compareTo(coordMidYempty_) == 0) {
    canSwap = true;
  }
  // can move current to top
  if (coordMidXcur_.compareTo(coordMidXempty_) == 0 &&
      coordMidYempty_.compareTo(yminusBoxWidth) == 0) {
    canSwap = true;
  }

  // old version without round and compareTo
  // if ((coordMidXcur + boxWidthAndSpaceBetween) == coordMidXempty &&
  //     coordMidYcur == coordMidYempty) {
  //   canSwap = true;
  // }
  // if (coordMidXcur == coordMidXempty &&
  //     (coordMidYcur + boxWidthAndSpaceBetween) == coordMidYempty) {
  //   canSwap = true;
  // }
  // if ((coordMidXcur - boxWidthAndSpaceBetween) == coordMidXempty &&
  //     coordMidYcur == coordMidYempty) {
  //   canSwap = true;
  // }
  // if (coordMidXcur == coordMidXempty &&
  //     (coordMidYcur - boxWidthAndSpaceBetween) == coordMidYempty) {
  //   canSwap = true;
  // }
  return canSwap;
}
