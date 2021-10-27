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
  Computed<Map<int, List<int>>>? _$indexesComputed;

  @override
  Map<int, List<int>> get indexes =>
      (_$indexesComputed ??= Computed<Map<int, List<int>>>(() => super.indexes,
              name: 'RoundBase.indexes'))
          .value;
  Computed<Duration?>? _$currentTimeComputed;

  @override
  Duration? get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration?>(() => super.currentTime,
              name: 'RoundBase.currentTime'))
          .value;

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
  void setDuration() {
    final _$actionInfo =
        _$RoundBaseActionController.startAction(name: 'RoundBase.setDuration');
    try {
      return super.setDuration();
    } finally {
      _$RoundBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void start(DateTime nowUtc) {
    final _$actionInfo =
        _$RoundBaseActionController.startAction(name: 'RoundBase.start');
    try {
      return super.start(nowUtc);
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
  String toString() {
    return '''
intervalIndex: ${intervalIndex},
intervalsCount: ${intervalsCount},
indexes: ${indexes},
currentTime: ${currentTime}
    ''';
  }
}
