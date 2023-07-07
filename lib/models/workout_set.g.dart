// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorkoutSet on WorkoutSetBase, Store {
  Computed<Duration?>? _$currentTimeComputed;

  @override
  Duration? get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration?>(() => super.currentTime,
              name: 'WorkoutSetBase.currentTime'))
          .value;

  late final _$_currentSetIndexAtom =
      Atom(name: 'WorkoutSetBase._currentSetIndex', context: context);

  @override
  int get _currentSetIndex {
    _$_currentSetIndexAtom.reportRead();
    return super._currentSetIndex;
  }

  @override
  set _currentSetIndex(int value) {
    _$_currentSetIndexAtom.reportWrite(value, super._currentSetIndex, () {
      super._currentSetIndex = value;
    });
  }

  late final _$WorkoutSetBaseActionController =
      ActionController(name: 'WorkoutSetBase', context: context);

  @override
  void setDuration({Duration? newDuration}) {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.setDuration');
    try {
      return super.setDuration(newDuration: newDuration);
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start(DateTime nowUtc) {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.start');
    try {
      return super.start(nowUtc);
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.pause');
    try {
      return super.pause();
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tick(DateTime nowUtc) {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.tick');
    try {
      return super.tick(nowUtc);
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTime: ${currentTime}
    ''';
  }
}
