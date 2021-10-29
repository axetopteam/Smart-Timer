// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_rest.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WorkRest on WorkRestBase, Store {
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout =>
      (_$workoutComputed ??= Computed<WorkoutSet>(() => super.workout,
              name: 'WorkRestBase.workout'))
          .value;

  final _$roundsCountAtom = Atom(name: 'WorkRestBase.roundsCount');

  @override
  int get roundsCount {
    _$roundsCountAtom.reportRead();
    return super.roundsCount;
  }

  @override
  set roundsCount(int value) {
    _$roundsCountAtom.reportWrite(value, super.roundsCount, () {
      super.roundsCount = value;
    });
  }

  final _$ratioAtom = Atom(name: 'WorkRestBase.ratio');

  @override
  int get ratio {
    _$ratioAtom.reportRead();
    return super.ratio;
  }

  @override
  set ratio(int value) {
    _$ratioAtom.reportWrite(value, super.ratio, () {
      super.ratio = value;
    });
  }

  final _$WorkRestBaseActionController = ActionController(name: 'WorkRestBase');

  @override
  void setRounds(int value) {
    final _$actionInfo = _$WorkRestBaseActionController.startAction(
        name: 'WorkRestBase.setRounds');
    try {
      return super.setRounds(value);
    } finally {
      _$WorkRestBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRatio(int value) {
    final _$actionInfo = _$WorkRestBaseActionController.startAction(
        name: 'WorkRestBase.setRatio');
    try {
      return super.setRatio(value);
    } finally {
      _$WorkRestBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
roundsCount: ${roundsCount},
ratio: ${ratio},
workout: ${workout}
    ''';
  }
}
