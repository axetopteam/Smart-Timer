// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CustomSettings on CustomSettingsBase, Store {
  Computed<Workout>? _$workoutComputed;

  @override
  Workout get workout =>
      (_$workoutComputed ??= Computed<Workout>(() => super.workout,
              name: 'CustomSettingsBase.workout'))
          .value;

  final _$roundsCountAtom = Atom(name: 'CustomSettingsBase.roundsCount');

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

  final _$intervalsAtom = Atom(name: 'CustomSettingsBase.intervals');

  @override
  ObservableList<Interval> get intervals {
    _$intervalsAtom.reportRead();
    return super.intervals;
  }

  @override
  set intervals(ObservableList<Interval> value) {
    _$intervalsAtom.reportWrite(value, super.intervals, () {
      super.intervals = value;
    });
  }

  final _$CustomSettingsBaseActionController =
      ActionController(name: 'CustomSettingsBase');

  @override
  void setRounds(int value) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.setRounds');
    try {
      return super.setRounds(value);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInterval(int index, Duration duration) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.setInterval');
    try {
      return super.setInterval(index, duration);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addInterval() {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.addInterval');
    try {
      return super.addInterval();
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteInterval(int index) {
    final _$actionInfo = _$CustomSettingsBaseActionController.startAction(
        name: 'CustomSettingsBase.deleteInterval');
    try {
      return super.deleteInterval(index);
    } finally {
      _$CustomSettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
roundsCount: ${roundsCount},
intervals: ${intervals},
workout: ${workout}
    ''';
  }
}
