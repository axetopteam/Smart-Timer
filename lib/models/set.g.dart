// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WorkoutSet on WorkoutSetBase, Store {
  Computed<int>? _$roundIndexComputed;

  @override
  int get roundIndex =>
      (_$roundIndexComputed ??= Computed<int>(() => super.roundIndex,
              name: 'WorkoutSetBase.roundIndex'))
          .value;
  Computed<int>? _$roundsCountComputed;

  @override
  int get roundsCount =>
      (_$roundsCountComputed ??= Computed<int>(() => super.roundsCount,
              name: 'WorkoutSetBase.roundsCount'))
          .value;
  Computed<int>? _$intervalIndexComputed;

  @override
  int get intervalIndex =>
      (_$intervalIndexComputed ??= Computed<int>(() => super.intervalIndex,
              name: 'WorkoutSetBase.intervalIndex'))
          .value;
  Computed<int>? _$intervalsCountComputed;

  @override
  int get intervalsCount =>
      (_$intervalsCountComputed ??= Computed<int>(() => super.intervalsCount,
              name: 'WorkoutSetBase.intervalsCount'))
          .value;
  Computed<Round>? _$_currentRoundComputed;

  @override
  Round get _currentRound =>
      (_$_currentRoundComputed ??= Computed<Round>(() => super._currentRound,
              name: 'WorkoutSetBase._currentRound'))
          .value;
  Computed<Duration>? _$currentTimeComputed;

  @override
  Duration get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration>(() => super.currentTime,
              name: 'WorkoutSetBase.currentTime'))
          .value;

  final _$_roundIndexAtom = Atom(name: 'WorkoutSetBase._roundIndex');

  @override
  int get _roundIndex {
    _$_roundIndexAtom.reportRead();
    return super._roundIndex;
  }

  @override
  set _roundIndex(int value) {
    _$_roundIndexAtom.reportWrite(value, super._roundIndex, () {
      super._roundIndex = value;
    });
  }

  final _$isEndedAtom = Atom(name: 'WorkoutSetBase.isEnded');

  @override
  bool get isEnded {
    _$isEndedAtom.reportRead();
    return super.isEnded;
  }

  @override
  set isEnded(bool value) {
    _$isEndedAtom.reportWrite(value, super.isEnded, () {
      super.isEnded = value;
    });
  }

  final _$WorkoutSetBaseActionController =
      ActionController(name: 'WorkoutSetBase');

  @override
  void tick() {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.tick');
    try {
      return super.tick();
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEnded: ${isEnded},
roundIndex: ${roundIndex},
roundsCount: ${roundsCount},
intervalIndex: ${intervalIndex},
intervalsCount: ${intervalsCount},
currentTime: ${currentTime}
    ''';
  }
}
