// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Interval on IntervalBase, Store {
  Computed<bool>? _$isEndedComputed;

  @override
  bool get isEnded => (_$isEndedComputed ??=
          Computed<bool>(() => super.isEnded, name: 'IntervalBase.isEnded'))
      .value;

  final _$currentTimeAtom = Atom(name: 'IntervalBase.currentTime');

  @override
  Duration get currentTime {
    _$currentTimeAtom.reportRead();
    return super.currentTime;
  }

  @override
  set currentTime(Duration value) {
    _$currentTimeAtom.reportWrite(value, super.currentTime, () {
      super.currentTime = value;
    });
  }

  final _$IntervalBaseActionController = ActionController(name: 'IntervalBase');

  @override
  void tick() {
    final _$actionInfo =
        _$IntervalBaseActionController.startAction(name: 'IntervalBase.tick');
    try {
      return super.tick();
    } finally {
      _$IntervalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTime: ${currentTime},
isEnded: ${isEnded}
    ''';
  }
}
