// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Workout on WorkoutBase, Store {
  Computed<int>? _$setIndexComputed;

  @override
  int get setIndex => (_$setIndexComputed ??=
          Computed<int>(() => super.setIndex, name: 'WorkoutBase.setIndex'))
      .value;
  Computed<int>? _$setsCountComputed;

  @override
  int get setsCount => (_$setsCountComputed ??=
          Computed<int>(() => super.setsCount, name: 'WorkoutBase.setsCount'))
      .value;
  Computed<int>? _$roundIndexComputed;

  @override
  int get roundIndex => (_$roundIndexComputed ??=
          Computed<int>(() => super.roundIndex, name: 'WorkoutBase.roundIndex'))
      .value;
  Computed<int>? _$roundsCountComputed;

  @override
  int get roundsCount =>
      (_$roundsCountComputed ??= Computed<int>(() => super.roundsCount,
              name: 'WorkoutBase.roundsCount'))
          .value;
  Computed<int>? _$intervalIndexComputed;

  @override
  int get intervalIndex =>
      (_$intervalIndexComputed ??= Computed<int>(() => super.intervalIndex,
              name: 'WorkoutBase.intervalIndex'))
          .value;
  Computed<int>? _$intervalsCountComputed;

  @override
  int get intervalsCount =>
      (_$intervalsCountComputed ??= Computed<int>(() => super.intervalsCount,
              name: 'WorkoutBase.intervalsCount'))
          .value;
  Computed<WorkoutSet>? _$_currentSetComputed;

  @override
  WorkoutSet get _currentSet =>
      (_$_currentSetComputed ??= Computed<WorkoutSet>(() => super._currentSet,
              name: 'WorkoutBase._currentSet'))
          .value;
  Computed<Duration>? _$currentTimeComputed;

  @override
  Duration get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration>(() => super.currentTime,
              name: 'WorkoutBase.currentTime'))
          .value;

  final _$statusAtom = Atom(name: 'WorkoutBase.status');

  @override
  TimerStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(TimerStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_setIndexAtom = Atom(name: 'WorkoutBase._setIndex');

  @override
  int get _setIndex {
    _$_setIndexAtom.reportRead();
    return super._setIndex;
  }

  @override
  set _setIndex(int value) {
    _$_setIndexAtom.reportWrite(value, super._setIndex, () {
      super._setIndex = value;
    });
  }

  final _$isEndedAtom = Atom(name: 'WorkoutBase.isEnded');

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

  final _$WorkoutBaseActionController = ActionController(name: 'WorkoutBase');

  @override
  void tick() {
    final _$actionInfo =
        _$WorkoutBaseActionController.startAction(name: 'WorkoutBase.tick');
    try {
      return super.tick();
    } finally {
      _$WorkoutBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start() {
    final _$actionInfo =
        _$WorkoutBaseActionController.startAction(name: 'WorkoutBase.start');
    try {
      return super.start();
    } finally {
      _$WorkoutBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo =
        _$WorkoutBaseActionController.startAction(name: 'WorkoutBase.pause');
    try {
      return super.pause();
    } finally {
      _$WorkoutBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resume() {
    final _$actionInfo =
        _$WorkoutBaseActionController.startAction(name: 'WorkoutBase.resume');
    try {
      return super.resume();
    } finally {
      _$WorkoutBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void close() {
    final _$actionInfo =
        _$WorkoutBaseActionController.startAction(name: 'WorkoutBase.close');
    try {
      return super.close();
    } finally {
      _$WorkoutBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
isEnded: ${isEnded},
setIndex: ${setIndex},
setsCount: ${setsCount},
roundIndex: ${roundIndex},
roundsCount: ${roundsCount},
intervalIndex: ${intervalIndex},
intervalsCount: ${intervalsCount},
currentTime: ${currentTime}
    ''';
  }
}
