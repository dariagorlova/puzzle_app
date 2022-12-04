import 'package:injectable/injectable.dart';
import 'package:puzzle_app/core/model/box.dart';

@lazySingleton
class CommonFunctions {
  List<int> createNewListOfNumbers() {
    return List.generate(
      16,
      (a) => a + 1,
    )..shuffle();
  }

  bool isPuzzleSolved(List<int> numbers) {
    var res = true;
    numbers.asMap().forEach((key, value) {
      if (key + 1 != value) {
        res = false;
      }
    });
    return res;
  }

  bool isSolvable(List<int> numbers) {
    var inversions = 0;
    var zeroPos = 0;
    const size = 16;
    final tmpList = List.generate(
      numbers.length,
      (index) => numbers.elementAt(index),
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
    return result;
  }

  List<BoxWithCoord> fillInitialCoordList(
    int boxWidthWithSpace,
    List<int> gameData,
  ) {
    final listBoxes = <BoxWithCoord>[];
    const startY = 0;
    const startX = 0;

    for (var i = 0; i < 16; i++) {
      var coordX = startX;
      var coordY = startY;

      if (i >= 0 && i < 4) {
        coordX = startX + i * boxWidthWithSpace;
        coordY = startY;
      } else if (i >= 4 && i < 8) {
        coordX = startX + (i - 4) * boxWidthWithSpace;
        coordY = startY + boxWidthWithSpace;
      } else if (i >= 8 && i < 12) {
        coordX = startX + (i - 8) * boxWidthWithSpace;
        coordY = startY + 2 * boxWidthWithSpace;
      } else if (i >= 12 && i < 16) {
        coordX = startX + (i - 12) * boxWidthWithSpace;
        coordY = startY + 3 * boxWidthWithSpace;
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

  List<BoxWithCoord> calculateBoxCoords(
    double startX,
    double startY,
    int boxWidth,
    int spaceBetweenBoxes,
    List<int> gameData,
  ) {
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
}
