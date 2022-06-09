// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Timer on TimerBase, Store {
  Computed<Interval>? _$currentIntervalComputed;

  @override
  Interval get currentInterval => (_$currentIntervalComputed ??=
          Computed<Interval>(() => super.currentInterval,
              name: 'TimerBase.currentInterval'))
      .value;
  Computed<String>? _$indexesComputed;

  @override
  String get indexes => (_$indexesComputed ??=
          Computed<String>(() => super.indexes, name: 'TimerBase.indexes'))
      .value;
  Computed<Duration?>? _$currentTimeComputed;

  @override
  Duration? get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration?>(() => super.currentTime,
              name: 'TimerBase.currentTime'))
          .value;

  late final _$statusAtom = Atom(name: 'TimerBase.status', context: context);

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

  late final _$TimerBaseActionController =
      ActionController(name: 'TimerBase', context: context);

  @override
  void start() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.start');
    try {
      return super.start();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.pause');
    try {
      return super.pause();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restart() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.restart');
    try {
      return super.restart();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tick(DateTime nowUtc) {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.tick');
    try {
      return super.tick(nowUtc);
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void close() {
    final _$actionInfo =
        _$TimerBaseActionController.startAction(name: 'TimerBase.close');
    try {
      return super.close();
    } finally {
      _$TimerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
currentInterval: ${currentInterval},
indexes: ${indexes},
currentTime: ${currentTime}
    ''';
  }
}
