import 'package:mocktail/mocktail.dart';
import 'package:puzzle_app/core/model/box.dart';
import 'package:puzzle_app/core/service/common_functions.dart';

class MockCommonFunctions extends Mock implements CommonFunctions {}

CommonFunctions getCommonFunctions() {
  final mock = MockCommonFunctions();

  when(mock.createNewListOfNumbers).thenReturn(listNumbers);

  when(() => mock.isSolvable(listNumbers)).thenReturn(true);

  when(() => mock.fillInitialCoordList(120, listNumbers)).thenReturn(listCoords);
  when(() => mock.fillInitialCoordList(120, listNumbersWinner)).thenReturn(listCoordsWinner);

  when(() => mock.isPuzzleCompleted(listCoordsWinner, listCoordsFirstStep)).thenReturn(false);
  when(() => mock.isPuzzleCompleted(listCoordsWinner, listCoordsWinner)).thenReturn(true);

  return mock;
}

const listNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 14, 15];

final listCoords = [
  BoxWithCoord(coordX: 0, coordY: 0, text: 1),
  BoxWithCoord(coordX: 120, coordY: 0, text: 2),
  BoxWithCoord(coordX: 240, coordY: 0, text: 3),
  BoxWithCoord(coordX: 360, coordY: 0, text: 4),
  BoxWithCoord(coordX: 0, coordY: 120, text: 5),
  BoxWithCoord(coordX: 120, coordY: 120, text: 6),
  BoxWithCoord(coordX: 240, coordY: 120, text: 7),
  BoxWithCoord(coordX: 360, coordY: 120, text: 8),
  BoxWithCoord(coordX: 0, coordY: 240, text: 9),
  BoxWithCoord(coordX: 120, coordY: 240, text: 10),
  BoxWithCoord(coordX: 240, coordY: 240, text: 11),
  BoxWithCoord(coordX: 360, coordY: 240, text: 12),
  BoxWithCoord(coordX: 0, coordY: 360, text: 13),
  BoxWithCoord(coordX: 120, coordY: 360, text: 16),
  BoxWithCoord(coordX: 240, coordY: 360, text: 14),
  BoxWithCoord(coordX: 360, coordY: 360, text: 15),
];

final listCoordsFirstStep = [
  BoxWithCoord(coordX: 0, coordY: 0, text: 1),
  BoxWithCoord(coordX: 120, coordY: 0, text: 2),
  BoxWithCoord(coordX: 240, coordY: 0, text: 3),
  BoxWithCoord(coordX: 360, coordY: 0, text: 4),
  BoxWithCoord(coordX: 0, coordY: 120, text: 5),
  BoxWithCoord(coordX: 120, coordY: 120, text: 6),
  BoxWithCoord(coordX: 240, coordY: 120, text: 7),
  BoxWithCoord(coordX: 360, coordY: 120, text: 8),
  BoxWithCoord(coordX: 0, coordY: 240, text: 9),
  BoxWithCoord(coordX: 120, coordY: 240, text: 10),
  BoxWithCoord(coordX: 240, coordY: 240, text: 11),
  BoxWithCoord(coordX: 360, coordY: 240, text: 12),
  BoxWithCoord(coordX: 0, coordY: 360, text: 13),
  BoxWithCoord(coordX: 240, coordY: 360, text: 16),
  BoxWithCoord(coordX: 120, coordY: 360, text: 14),
  BoxWithCoord(coordX: 360, coordY: 360, text: 15),
];

final listCoordsWinner = [
  BoxWithCoord(coordX: 0, coordY: 0, text: 1),
  BoxWithCoord(coordX: 120, coordY: 0, text: 2),
  BoxWithCoord(coordX: 240, coordY: 0, text: 3),
  BoxWithCoord(coordX: 360, coordY: 0, text: 4),
  BoxWithCoord(coordX: 0, coordY: 120, text: 5),
  BoxWithCoord(coordX: 120, coordY: 120, text: 6),
  BoxWithCoord(coordX: 240, coordY: 120, text: 7),
  BoxWithCoord(coordX: 360, coordY: 120, text: 8),
  BoxWithCoord(coordX: 0, coordY: 240, text: 9),
  BoxWithCoord(coordX: 120, coordY: 240, text: 10),
  BoxWithCoord(coordX: 240, coordY: 240, text: 11),
  BoxWithCoord(coordX: 360, coordY: 240, text: 12),
  BoxWithCoord(coordX: 0, coordY: 360, text: 13),
  BoxWithCoord(coordX: 360, coordY: 360, text: 16),
  BoxWithCoord(coordX: 120, coordY: 360, text: 14),
  BoxWithCoord(coordX: 240, coordY: 360, text: 15),
];

const listNumbersWinner = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
];
