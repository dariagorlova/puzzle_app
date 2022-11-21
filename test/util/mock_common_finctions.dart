import 'package:mocktail/mocktail.dart';
import 'package:puzzle_app/core/service/common_functions.dart';

class MockCommonFunctions extends Mock implements CommonFunctions {}

CommonFunctions getCommonFunctions() {
  final mock = MockCommonFunctions();
  when(mock.createNewListOfNumbers)
      .thenReturn([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 14, 15]);
  //.thenReturn([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 15]);

  return mock;
}
