// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimerState on TimerStateBase, Store {
  Computed<WorkoutInterval>? _$currentIntervalComputed;

  @override
  WorkoutInterval get currentInterval => (_$currentIntervalComputed ??=
          Computed<WorkoutInterval>(() => super.currentInterval,
              name: 'TimerStateBase.currentInterval'))
      .value;
  Computed<Duration?>? _$currentTimeComputed;

  @override
  Duration? get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration?>(() => super.currentTime,
              name: 'TimerStateBase.currentTime'))
          .value;

  late final _$currentStateAtom =
      Atom(name: 'TimerStateBase.currentState', context: context);

  @override
  TimerStatus get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(TimerStatus value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  late final _$totalRestTimeAtom =
      Atom(name: 'TimerStateBase.totalRestTime', context: context);

  @override
  Duration? get totalRestTime {
    _$totalRestTimeAtom.reportRead();
    return super.totalRestTime;
  }

  @override
  set totalRestTime(Duration? value) {
    _$totalRestTimeAtom.reportWrite(value, super.totalRestTime, () {
      super.totalRestTime = value;
    });
  }

  late final _$soundOnAtom =
      Atom(name: 'TimerStateBase.soundOn', context: context);

  @override
  bool get soundOn {
    _$soundOnAtom.reportRead();
    return super.soundOn;
  }

  @override
  set soundOn(bool value) {
    _$soundOnAtom.reportWrite(value, super.soundOn, () {
      super.soundOn = value;
    });
  }

  late final _$switchSoundOnOffAsyncAction =
      AsyncAction('TimerStateBase.switchSoundOnOff', context: context);

  @override
  Future<void> switchSoundOnOff() {
    return _$switchSoundOnOffAsyncAction.run(() => super.switchSoundOnOff());
  }

  late final _$TimerStateBaseActionController =
      ActionController(name: 'TimerStateBase', context: context);

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
  void tick(DateTime nowUtc) {
    final _$actionInfo = _$TimerStateBaseActionController.startAction(
        name: 'TimerStateBase.tick');
    try {
      return super.tick(nowUtc);
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
currentState: ${currentState},
totalRestTime: ${totalRestTime},
soundOn: ${soundOn},
currentInterval: ${currentInterval},
currentTime: ${currentTime}
    ''';
  }
}
