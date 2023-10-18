// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  List<BoxWithCoord> get listBoxes => throw _privateConstructorUsedError;
  dynamic get stepsCount => throw _privateConstructorUsedError;
  bool get gameHasBegun => throw _privateConstructorUsedError;
  bool get playerWin => throw _privateConstructorUsedError;
  dynamic get gameStartTimeInMilliSecSinceEpoch =>
      throw _privateConstructorUsedError;
  double get boxSize => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {List<int> numbers,
      List<BoxWithCoord> listBoxes,
      dynamic stepsCount,
      bool gameHasBegun,
      bool playerWin,
      dynamic gameStartTimeInMilliSecSinceEpoch,
      double boxSize});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numbers = null,
    Object? listBoxes = null,
    Object? stepsCount = freezed,
    Object? gameHasBegun = null,
    Object? playerWin = null,
    Object? gameStartTimeInMilliSecSinceEpoch = freezed,
    Object? boxSize = null,
  }) {
    return _then(_value.copyWith(
      numbers: null == numbers
          ? _value.numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      listBoxes: null == listBoxes
          ? _value.listBoxes
          : listBoxes // ignore: cast_nullable_to_non_nullable
              as List<BoxWithCoord>,
      stepsCount: freezed == stepsCount
          ? _value.stepsCount
          : stepsCount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      gameHasBegun: null == gameHasBegun
          ? _value.gameHasBegun
          : gameHasBegun // ignore: cast_nullable_to_non_nullable
              as bool,
      playerWin: null == playerWin
          ? _value.playerWin
          : playerWin // ignore: cast_nullable_to_non_nullable
              as bool,
      gameStartTimeInMilliSecSinceEpoch: freezed ==
              gameStartTimeInMilliSecSinceEpoch
          ? _value.gameStartTimeInMilliSecSinceEpoch
          : gameStartTimeInMilliSecSinceEpoch // ignore: cast_nullable_to_non_nullable
              as dynamic,
      boxSize: null == boxSize
          ? _value.boxSize
          : boxSize // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> numbers,
      List<BoxWithCoord> listBoxes,
      dynamic stepsCount,
      bool gameHasBegun,
      bool playerWin,
      dynamic gameStartTimeInMilliSecSinceEpoch,
      double boxSize});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numbers = null,
    Object? listBoxes = null,
    Object? stepsCount = freezed,
    Object? gameHasBegun = null,
    Object? playerWin = null,
    Object? gameStartTimeInMilliSecSinceEpoch = freezed,
    Object? boxSize = null,
  }) {
    return _then(_$GameStateImpl(
      numbers: null == numbers
          ? _value._numbers
          : numbers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      listBoxes: null == listBoxes
          ? _value._listBoxes
          : listBoxes // ignore: cast_nullable_to_non_nullable
              as List<BoxWithCoord>,
      stepsCount: freezed == stepsCount ? _value.stepsCount! : stepsCount,
      gameHasBegun: null == gameHasBegun
          ? _value.gameHasBegun
          : gameHasBegun // ignore: cast_nullable_to_non_nullable
              as bool,
      playerWin: null == playerWin
          ? _value.playerWin
          : playerWin // ignore: cast_nullable_to_non_nullable
              as bool,
      gameStartTimeInMilliSecSinceEpoch:
          freezed == gameStartTimeInMilliSecSinceEpoch
              ? _value.gameStartTimeInMilliSecSinceEpoch!
              : gameStartTimeInMilliSecSinceEpoch,
      boxSize: null == boxSize
          ? _value.boxSize
          : boxSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {final List<int> numbers = const [],
      final List<BoxWithCoord> listBoxes = const [],
      this.stepsCount = 0,
      this.gameHasBegun = false,
      this.playerWin = false,
      this.gameStartTimeInMilliSecSinceEpoch = 0,
      this.boxSize = 50})
      : _numbers = numbers,
        _listBoxes = listBoxes;

  final List<int> _numbers;
  @override
  @JsonKey()
  List<int> get numbers {
    if (_numbers is EqualUnmodifiableListView) return _numbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_numbers);
  }

  final List<BoxWithCoord> _listBoxes;
  @override
  @JsonKey()
  List<BoxWithCoord> get listBoxes {
    if (_listBoxes is EqualUnmodifiableListView) return _listBoxes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listBoxes);
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
  @JsonKey()
  final double boxSize;

  @override
  String toString() {
    return 'GameState(numbers: $numbers, listBoxes: $listBoxes, stepsCount: $stepsCount, gameHasBegun: $gameHasBegun, playerWin: $playerWin, gameStartTimeInMilliSecSinceEpoch: $gameStartTimeInMilliSecSinceEpoch, boxSize: $boxSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            const DeepCollectionEquality().equals(other._numbers, _numbers) &&
            const DeepCollectionEquality()
                .equals(other._listBoxes, _listBoxes) &&
            const DeepCollectionEquality()
                .equals(other.stepsCount, stepsCount) &&
            (identical(other.gameHasBegun, gameHasBegun) ||
                other.gameHasBegun == gameHasBegun) &&
            (identical(other.playerWin, playerWin) ||
                other.playerWin == playerWin) &&
            const DeepCollectionEquality().equals(
                other.gameStartTimeInMilliSecSinceEpoch,
                gameStartTimeInMilliSecSinceEpoch) &&
            (identical(other.boxSize, boxSize) || other.boxSize == boxSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_numbers),
      const DeepCollectionEquality().hash(_listBoxes),
      const DeepCollectionEquality().hash(stepsCount),
      gameHasBegun,
      playerWin,
      const DeepCollectionEquality().hash(gameStartTimeInMilliSecSinceEpoch),
      boxSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final List<int> numbers,
      final List<BoxWithCoord> listBoxes,
      final dynamic stepsCount,
      final bool gameHasBegun,
      final bool playerWin,
      final dynamic gameStartTimeInMilliSecSinceEpoch,
      final double boxSize}) = _$GameStateImpl;

  @override
  List<int> get numbers;
  @override
  List<BoxWithCoord> get listBoxes;
  @override
  dynamic get stepsCount;
  @override
  bool get gameHasBegun;
  @override
  bool get playerWin;
  @override
  dynamic get gameStartTimeInMilliSecSinceEpoch;
  @override
  double get boxSize;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
