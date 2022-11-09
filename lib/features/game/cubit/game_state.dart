import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<int> numbers,
    @Default(0) stepsCount,
    @Default(false) bool gameHasBegun,
    @Default(false) bool playerWin,
    @Default(0) gameStartTimeInMilliSecSinceEpoch,
  }) = _GameState;
}

extension XGameState on GameState {
  //bool get canSwap => answers[attempt].any((l) => l.letter.isNotEmpty);
  //int get gameTime => (DateTime.now().millisecondsSinceEpoch.toInt() -
  //    millisecondsSinceEpochStart!) as int;
}
