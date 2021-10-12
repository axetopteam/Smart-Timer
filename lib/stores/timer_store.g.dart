// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerState on TimerStateBase, Store {
  Computed<Round>? _$currentRoundComputed;

  @override
  Round get currentRound =>
      (_$currentRoundComputed ??= Computed<Round>(() => super.currentRound,
              name: 'TimerStateBase.currentRound'))
          .value;
  Computed<Interval>? _$currentIntervalComputed;

  @override
  Interval get currentInterval => (_$currentIntervalComputed ??=
          Computed<Interval>(() => super.currentInterval,
              name: 'TimerStateBase.currentInterval'))
      .value;
  Computed<IntervalType>? _$currentTypeComputed;

  @override
  IntervalType get currentType =>
      (_$currentTypeComputed ??= Computed<IntervalType>(() => super.currentType,
              name: 'TimerStateBase.currentType'))
          .value;
  Computed<int>? _$roundNumberComputed;

  @override
  int get roundNumber =>
      (_$roundNumberComputed ??= Computed<int>(() => super.roundNumber,
              name: 'TimerStateBase.roundNumber'))
          .value;

  final _$timeAtom = Atom(name: 'TimerStateBase.time');

  @override
  Duration get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(Duration value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  final _$statusAtom = Atom(name: 'TimerStateBase.status');

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

  final _$roundIndexAtom = Atom(name: 'TimerStateBase.roundIndex');

  @override
  int get roundIndex {
    _$roundIndexAtom.reportRead();
    return super.roundIndex;
  }

  @override
  set roundIndex(int value) {
    _$roundIndexAtom.reportWrite(value, super.roundIndex, () {
      super.roundIndex = value;
    });
  }

  final _$intervalIndexAtom = Atom(name: 'TimerStateBase.intervalIndex');

  @override
  int get intervalIndex {
    _$intervalIndexAtom.reportRead();
    return super.intervalIndex;
  }

  @override
  set intervalIndex(int value) {
    _$intervalIndexAtom.reportWrite(value, super.intervalIndex, () {
      super.intervalIndex = value;
    });
  }

  final _$TimerStateBaseActionController =
      ActionController(name: 'TimerStateBase');

  @override
  void tick() {
    final _$actionInfo = _$TimerStateBaseActionController.startAction(
        name: 'TimerStateBase.tick');
    try {
      return super.tick();
    } finally {
      _$TimerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start() {
    final _$actionInfo = _$TimerStateBaseActionController.startAction(
        name: 'TimerStateBase.start');
    try {
      return super.start();
    } finally {
      _$TimerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo = _$TimerStateBaseActionController.startAction(
        name: 'TimerStateBase.pause');
    try {
      return super.pause();
    } finally {
      _$TimerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resume() {
    final _$actionInfo = _$TimerStateBaseActionController.startAction(
        name: 'TimerStateBase.resume');
    try {
      return super.resume();
    } finally {
      _$TimerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void close() {
    final _$actionInfo = _$TimerStateBaseActionController.startAction(
        name: 'TimerStateBase.close');
    try {
      return super.close();
    } finally {
      _$TimerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
time: ${time},
status: ${status},
roundIndex: ${roundIndex},
intervalIndex: ${intervalIndex},
currentRound: ${currentRound},
currentInterval: ${currentInterval},
currentType: ${currentType},
roundNumber: ${roundNumber}
    ''';
  }
}
