// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerState on TimerStateBase, Store {
  Computed<Interval>? _$currentIntervalComputed;

  @override
  Interval get currentInterval => (_$currentIntervalComputed ??=
          Computed<Interval>(() => super.currentInterval,
              name: 'TimerStateBase.currentInterval'))
      .value;
  Computed<int>? _$currentRoundComputed;

  @override
  int get currentRound =>
      (_$currentRoundComputed ??= Computed<int>(() => super.currentRound,
              name: 'TimerStateBase.currentRound'))
          .value;

  final _$restTimeAtom = Atom(name: 'TimerStateBase.restTime');

  @override
  Duration get restTime {
    _$restTimeAtom.reportRead();
    return super.restTime;
  }

  @override
  set restTime(Duration value) {
    _$restTimeAtom.reportWrite(value, super.restTime, () {
      super.restTime = value;
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
  String toString() {
    return '''
restTime: ${restTime},
status: ${status},
intervalIndex: ${intervalIndex},
currentInterval: ${currentInterval},
currentRound: ${currentRound}
    ''';
  }
}
