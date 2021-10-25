// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Round on RoundBase, Store {
  Computed<int>? _$intervalIndexComputed;

  @override
  int get intervalIndex =>
      (_$intervalIndexComputed ??= Computed<int>(() => super.intervalIndex,
              name: 'RoundBase.intervalIndex'))
          .value;
  Computed<int>? _$intervalsCountComputed;

  @override
  int get intervalsCount =>
      (_$intervalsCountComputed ??= Computed<int>(() => super.intervalsCount,
              name: 'RoundBase.intervalsCount'))
          .value;
  Computed<Duration>? _$currentTimeComputed;

  @override
  Duration get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration>(() => super.currentTime,
              name: 'RoundBase.currentTime'))
          .value;

  final _$statusAtom = Atom(name: 'RoundBase.status');

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

  final _$_intervalIndexAtom = Atom(name: 'RoundBase._intervalIndex');

  @override
  int get _intervalIndex {
    _$_intervalIndexAtom.reportRead();
    return super._intervalIndex;
  }

  @override
  set _intervalIndex(int value) {
    _$_intervalIndexAtom.reportWrite(value, super._intervalIndex, () {
      super._intervalIndex = value;
    });
  }

  final _$RoundBaseActionController = ActionController(name: 'RoundBase');

  @override
  void tick(DateTime nowUtc) {
    final _$actionInfo =
        _$RoundBaseActionController.startAction(name: 'RoundBase.tick');
    try {
      return super.tick(nowUtc);
    } finally {
      _$RoundBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start() {
    final _$actionInfo =
        _$RoundBaseActionController.startAction(name: 'RoundBase.start');
    try {
      return super.start();
    } finally {
      _$RoundBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo =
        _$RoundBaseActionController.startAction(name: 'RoundBase.pause');
    try {
      return super.pause();
    } finally {
      _$RoundBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void close() {
    final _$actionInfo =
        _$RoundBaseActionController.startAction(name: 'RoundBase.close');
    try {
      return super.close();
    } finally {
      _$RoundBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
intervalIndex: ${intervalIndex},
intervalsCount: ${intervalsCount},
currentTime: ${currentTime}
    ''';
  }
}
