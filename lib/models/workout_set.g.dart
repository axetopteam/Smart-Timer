// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WorkoutSet on WorkoutSetBase, Store {
  Computed<Duration?>? _$currentTimeComputed;

  @override
  Duration? get currentTime =>
      (_$currentTimeComputed ??= Computed<Duration?>(() => super.currentTime,
              name: 'WorkoutSetBase.currentTime'))
          .value;
  Computed<Map<int, List<int>>>? _$indexesComputed;

  @override
  Map<int, List<int>> get indexes =>
      (_$indexesComputed ??= Computed<Map<int, List<int>>>(() => super.indexes,
              name: 'WorkoutSetBase.indexes'))
          .value;
  Computed<bool>? _$isLastComputed;

  @override
  bool get isLast => (_$isLastComputed ??=
          Computed<bool>(() => super.isLast, name: 'WorkoutSetBase.isLast'))
      .value;

  final _$_setIndexAtom = Atom(name: 'WorkoutSetBase._setIndex');

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

  final _$WorkoutSetBaseActionController =
      ActionController(name: 'WorkoutSetBase');

  @override
  void setDuration({Duration? newDuration}) {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.setDuration');
    try {
      return super.setDuration(newDuration: newDuration);
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start(DateTime nowUtc) {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.start');
    try {
      return super.start(nowUtc);
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pause() {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.pause');
    try {
      return super.pause();
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void tick(DateTime nowUtc) {
    final _$actionInfo = _$WorkoutSetBaseActionController.startAction(
        name: 'WorkoutSetBase.tick');
    try {
      return super.tick(nowUtc);
    } finally {
      _$WorkoutSetBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTime: ${currentTime},
indexes: ${indexes},
isLast: ${isLast}
    ''';
  }
}
