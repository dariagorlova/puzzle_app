import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:puzzle_app/core/model/box.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<int> numbers,
    @Default([]) List<BoxWithCoord> listBoxes,
    @Default(0) stepsCount,
    @Default(false) bool gameHasBegun,
    //@Default(false) bool playerWin,
    @Default(0) gameStartTimeInMilliSecSinceEpoch,
  }) = _GameState;
}
