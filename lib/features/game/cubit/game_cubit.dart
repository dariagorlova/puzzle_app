import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/core/model/box.dart';
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

    //final boxes = calculateBoxCoords(0, 0, 50, 10);
    //emit(state.copyWith(boxes: boxes));
  }

  List<BoxWithCoord> calculateBoxCoords(
    double startX,
    double startY,
    int boxWidth,
    int spaceBetweenBoxes,
  ) {
    final gameData = state.numbers;
    final listBoxes = <BoxWithCoord>[];

    for (var i = 0; i < 16; i++) {
      var coordX = startX;
      var coordY = startY;

      if (i >= 0 && i < 4) {
        coordX = startX + i * (boxWidth + spaceBetweenBoxes);
        coordY = startY;
      } else if (i >= 4 && i < 8) {
        coordX = startX + (i - 4) * (boxWidth + spaceBetweenBoxes);
        coordY = startY + (boxWidth + spaceBetweenBoxes);
      } else if (i >= 8 && i < 12) {
        coordX = startX + (i - 8) * (boxWidth + spaceBetweenBoxes);
        coordY = startY + 2 * (boxWidth + spaceBetweenBoxes);
      } else if (i >= 12 && i < 16) {
        coordX = startX + (i - 12) * (boxWidth + spaceBetweenBoxes);
        coordY = startY + 3 * (boxWidth + spaceBetweenBoxes);
      }

      listBoxes.add(
        BoxWithCoord(
          coordX: coordX,
          coordY: coordY,
          text: gameData[i],
        ),
      );
    }

    return listBoxes;
  }

  // void swapedBoxes(List<BoxWithCoord> list) {
  //   final s = state.stepsCount + 1;
  //   emit(state.copyWith(stepsCount: s));

  //   if (isPuzzleSolved()) {
  //     emit(state.copyWith(gameHasBegun: false, playerWin: true));
  //   }
  // }

  void swapBoxes(
    int curNum,
    List<BoxWithCoord> listBoxes,
    int boxWidth,
    int spaceBetweenBoxes,
  ) {
    final curElement =
        listBoxes.firstWhere((element) => element.text == curNum);
    final curElementIndex =
        listBoxes.indexWhere((element) => element == curElement);
    final coordMidXcur = curElement.coordX + boxWidth / 2;
    final coordMidYcur = curElement.coordY + boxWidth / 2;

    final emptyElement = listBoxes.firstWhere((element) => element.text == 16);
    final emptyIndex =
        listBoxes.indexWhere((element) => element == emptyElement);
    final coordMidXempty = emptyElement.coordX + boxWidth / 2;
    final coordMidYempty = emptyElement.coordY + boxWidth / 2;

    var canSwap = false;
    final boxWidthAndSpaceBetween = boxWidth + spaceBetweenBoxes;

    // can move current to right
    if ((coordMidXcur + boxWidthAndSpaceBetween) == coordMidXempty &&
        coordMidYcur == coordMidYempty) {
      canSwap = true;
    }
    // can move current to down
    if (coordMidXcur == coordMidXempty &&
        (coordMidYcur + boxWidthAndSpaceBetween) == coordMidYempty) {
      canSwap = true;
    }
    // can move current to left
    if ((coordMidXcur - boxWidthAndSpaceBetween) == coordMidXempty &&
        coordMidYcur == coordMidYempty) {
      canSwap = true;
    }
    // can move current to top
    if (coordMidXcur == coordMidXempty &&
        (coordMidYcur - boxWidthAndSpaceBetween) == coordMidYempty) {
      canSwap = true;
    }

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

      final s = state.stepsCount + 1;
      emit(
        state.copyWith(
          stepsCount: s,
        ),
      );

      //if (isPuzzleCompleted()) {
      //  emit(state.copyWith(gameHasBegun: false, playerWin: true));
      //}
    }
  }

  void gameFinished() {
    emit(state.copyWith(gameHasBegun: false, playerWin: true));
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

  List<BoxWithCoord> fillInitialList(
    int startX,
    int startY,
    int boxWidth,
    int spaceBetweenBoxes,
    List<int> gameData,
  ) {
    final listBoxes = <BoxWithCoord>[];

    //final gameData = state.numbers;

    for (var i = 0; i < 16; i++) {
      var coordX = startX;
      var coordY = startY;

      if (i >= 0 && i < 4) {
        coordX = startX + i * (boxWidth + spaceBetweenBoxes);
        coordY = startY;
      } else if (i >= 4 && i < 8) {
        coordX = startX + (i - 4) * (boxWidth + spaceBetweenBoxes);
        coordY = startY + (boxWidth + spaceBetweenBoxes);
      } else if (i >= 8 && i < 12) {
        coordX = startX + (i - 8) * (boxWidth + spaceBetweenBoxes);
        coordY = startY + 2 * (boxWidth + spaceBetweenBoxes);
      } else if (i >= 12 && i < 16) {
        coordX = startX + (i - 12) * (boxWidth + spaceBetweenBoxes);
        coordY = startY + 3 * (boxWidth + spaceBetweenBoxes);
      }

      listBoxes.add(
        BoxWithCoord(
          coordX: coordX.toDouble(),
          coordY: coordY.toDouble(),
          text: gameData[i],
        ),
      );
    }
    return listBoxes;
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
