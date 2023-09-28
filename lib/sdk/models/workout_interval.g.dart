// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_interval.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorkoutInterval on WorkoutIntervalBase, Store {
  Computed<bool>? _$isFirstSecondComputed;

  @override
  bool get isFirstSecond =>
      (_$isFirstSecondComputed ??= Computed<bool>(() => super.isFirstSecond,
              name: 'WorkoutIntervalBase.isFirstSecond'))
          .value;

  late final _$_currentTimeAtom =
      Atom(name: 'WorkoutIntervalBase._currentTime', context: context);

  @override
  Duration? get _currentTime {
    _$_currentTimeAtom.reportRead();
    return super._currentTime;
  }

  @override
  set _currentTime(Duration? value) {
    _$_currentTimeAtom.reportWrite(value, super._currentTime, () {
      super._currentTime = value;
    });
  }

  late final _$WorkoutIntervalBaseActionController =
      ActionController(name: 'WorkoutIntervalBase', context: context);

  @override
  void setDuration({Duration? newDuration}) {
    final _$actionInfo = _$WorkoutIntervalBaseActionController.startAction(
        name: 'WorkoutIntervalBase.setDuration');
    try {
      return super.setDuration(newDuration: newDuration);
    } finally {
      _$WorkoutIntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start(DateTime nowUtc) {
    final _$actionInfo = _$WorkoutIntervalBaseActionController.startAction(
        name: 'WorkoutIntervalBase.start');
    try {
      return super.start(nowUtc);
    } finally {
      _$WorkoutIntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo = _$WorkoutIntervalBaseActionController.startAction(
        name: 'WorkoutIntervalBase.pause');
    try {
      return super.pause();
    } finally {
      _$WorkoutIntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$WorkoutIntervalBaseActionController.startAction(
        name: 'WorkoutIntervalBase.reset');
    try {
      return super.reset();
    } finally {
      _$WorkoutIntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tick(DateTime nowUtc) {
    final _$actionInfo = _$WorkoutIntervalBaseActionController.startAction(
        name: 'WorkoutIntervalBase.tick');
    try {
      return super.tick(nowUtc);
    } finally {
      _$WorkoutIntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFirstSecond: ${isFirstSecond}
    ''';
  }
}
