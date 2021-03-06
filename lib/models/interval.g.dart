// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Interval on IntervalBase, Store {
  Computed<bool>? _$isFirstSecondComputed;

  @override
  bool get isFirstSecond =>
      (_$isFirstSecondComputed ??= Computed<bool>(() => super.isFirstSecond,
              name: 'IntervalBase.isFirstSecond'))
          .value;
  Computed<Map<int, List<int>>>? _$indexesComputed;

  @override
  Map<int, List<int>> get indexes =>
      (_$indexesComputed ??= Computed<Map<int, List<int>>>(() => super.indexes,
              name: 'IntervalBase.indexes'))
          .value;

  late final _$_currentTimeAtom =
      Atom(name: 'IntervalBase._currentTime', context: context);

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

  late final _$IntervalBaseActionController =
      ActionController(name: 'IntervalBase', context: context);

  @override
  void setDuration({Duration? newDuration}) {
    final _$actionInfo = _$IntervalBaseActionController.startAction(
        name: 'IntervalBase.setDuration');
    try {
      return super.setDuration(newDuration: newDuration);
    } finally {
      _$IntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start(DateTime nowUtc) {
    final _$actionInfo =
        _$IntervalBaseActionController.startAction(name: 'IntervalBase.start');
    try {
      return super.start(nowUtc);
    } finally {
      _$IntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo =
        _$IntervalBaseActionController.startAction(name: 'IntervalBase.pause');
    try {
      return super.pause();
    } finally {
      _$IntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo =
        _$IntervalBaseActionController.startAction(name: 'IntervalBase.reset');
    try {
      return super.reset();
    } finally {
      _$IntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tick(DateTime nowUtc) {
    final _$actionInfo =
        _$IntervalBaseActionController.startAction(name: 'IntervalBase.tick');
    try {
      return super.tick(nowUtc);
    } finally {
      _$IntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFirstSecond: ${isFirstSecond},
indexes: ${indexes}
    ''';
  }
}
