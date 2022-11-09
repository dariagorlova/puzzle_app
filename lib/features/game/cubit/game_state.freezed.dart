// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameState {
  List<int> get numbers => throw _privateConstructorUsedError;
  dynamic get stepsCount => throw _privateConstructorUsedError;
  bool get gameHasBegun => throw _privateConstructorUsedError;
  bool get playerWin => throw _privateConstructorUsedError;
  dynamic get gameStartTimeInMilliSecSinceEpoch =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res>;
  $Res call(
      {List<int> numbers,
      dynamic stepsCount,
      bool gameHasBegun,
      bool playerWin,
      dynamic gameStartTimeInMilliSecSinceEpoch});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res> implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  final GameState _value;
  // ignore: unused_field
  final $Res Function(GameState) _then;

  @override
  $Res call({
    Object? numbers = freezed,
    Object? stepsCount = freezed,
    Object? gameHasBegun = freezed,
    Object? playerWin = freezed,
    Object? gameStartTimeInMilliSecSinceEpoch = freezed,
  }) {
    return _then(_value.copyWith(
      numbers: numbers == freezed
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stepsCount: stepsCount == freezed
          ? _value.stepsCount
          : stepsCount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      gameHasBegun: gameHasBegun == freezed
          ? _value.gameHasBegun
          : gameHasBegun // ignore: cast_nullable_to_non_nullable
              as bool,
      playerWin: playerWin == freezed
          ? _value.playerWin
          : playerWin // ignore: cast_nullable_to_non_nullable
              as bool,
      gameStartTimeInMilliSecSinceEpoch: gameStartTimeInMilliSecSinceEpoch ==
              freezed
          ? _value.gameStartTimeInMilliSecSinceEpoch
          : gameStartTimeInMilliSecSinceEpoch // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<int> numbers,
      dynamic stepsCount,
      bool gameHasBegun,
      bool playerWin,
      dynamic gameStartTimeInMilliSecSinceEpoch});
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res> extends _$GameStateCopyWithImpl<$Res>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, (v) => _then(v as _$_GameState));

  @override
  _$_GameState get _value => super._value as _$_GameState;

  @override
  $Res call({
    Object? numbers = freezed,
    Object? stepsCount = freezed,
    Object? gameHasBegun = freezed,
    Object? playerWin = freezed,
    Object? gameStartTimeInMilliSecSinceEpoch = freezed,
  }) {
    return _then(_$_GameState(
      numbers: numbers == freezed
          ? _value._numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stepsCount: stepsCount == freezed ? _value.stepsCount : stepsCount,
      gameHasBegun: gameHasBegun == freezed
          ? _value.gameHasBegun
          : gameHasBegun // ignore: cast_nullable_to_non_nullable
              as bool,
      playerWin: playerWin == freezed
          ? _value.playerWin
          : playerWin // ignore: cast_nullable_to_non_nullable
              as bool,
      gameStartTimeInMilliSecSinceEpoch:
          gameStartTimeInMilliSecSinceEpoch == freezed
              ? _value.gameStartTimeInMilliSecSinceEpoch
              : gameStartTimeInMilliSecSinceEpoch,
    ));
  }
}

/// @nodoc

class _$_GameState implements _GameState {
  const _$_GameState(
      {final List<int> numbers = const [],
      this.stepsCount = 0,
      this.gameHasBegun = false,
      this.playerWin = false,
      this.gameStartTimeInMilliSecSinceEpoch = 0})
      : _numbers = numbers;

  final List<int> _numbers;
  @override
  @JsonKey()
  List<int> get numbers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_numbers);
  }

  @override
  @JsonKey()
  final dynamic stepsCount;
  @override
  @JsonKey()
  final bool gameHasBegun;
  @override
  @JsonKey()
  final bool playerWin;
  @override
  @JsonKey()
  final dynamic gameStartTimeInMilliSecSinceEpoch;

  @override
  String toString() {
    return 'GameState(numbers: $numbers, stepsCount: $stepsCount, gameHasBegun: $gameHasBegun, playerWin: $playerWin, gameStartTimeInMilliSecSinceEpoch: $gameStartTimeInMilliSecSinceEpoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            const DeepCollectionEquality().equals(other._numbers, _numbers) &&
            const DeepCollectionEquality()
                .equals(other.stepsCount, stepsCount) &&
            const DeepCollectionEquality()
                .equals(other.gameHasBegun, gameHasBegun) &&
            const DeepCollectionEquality().equals(other.playerWin, playerWin) &&
            const DeepCollectionEquality().equals(
                other.gameStartTimeInMilliSecSinceEpoch,
                gameStartTimeInMilliSecSinceEpoch));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_numbers),
      const DeepCollectionEquality().hash(stepsCount),
      const DeepCollectionEquality().hash(gameHasBegun),
      const DeepCollectionEquality().hash(playerWin),
      const DeepCollectionEquality().hash(gameStartTimeInMilliSecSinceEpoch));

  @JsonKey(ignore: true)
  @override
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final List<int> numbers,
      final dynamic stepsCount,
      final bool gameHasBegun,
      final bool playerWin,
      final dynamic gameStartTimeInMilliSecSinceEpoch}) = _$_GameState;

  @override
  List<int> get numbers;
  @override
  dynamic get stepsCount;
  @override
  bool get gameHasBegun;
  @override
  bool get playerWin;
  @override
  dynamic get gameStartTimeInMilliSecSinceEpoch;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
