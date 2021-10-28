// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'afap.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Afap on AfapBase, Store {
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout => (_$workoutComputed ??=
          Computed<WorkoutSet>(() => super.workout, name: 'AfapBase.workout'))
      .value;

  final _$workTimeAtom = Atom(name: 'AfapBase.workTime');

  @override
  Interval get workTime {
    _$workTimeAtom.reportRead();
    return super.workTime;
  }

  @override
  set workTime(Interval value) {
    _$workTimeAtom.reportWrite(value, super.workTime, () {
      super.workTime = value;
    });
  }

  final _$AfapBaseActionController = ActionController(name: 'AfapBase');

  @override
  void setTimeCap(Duration? duration) {
    final _$actionInfo =
        _$AfapBaseActionController.startAction(name: 'AfapBase.setTimeCap');
    try {
      return super.setTimeCap(duration);
    } finally {
      _$AfapBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
workTime: ${workTime},
workout: ${workout}
    ''';
  }
}
