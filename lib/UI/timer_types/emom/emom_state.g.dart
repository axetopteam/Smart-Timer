// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emom_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmomState on EmomStateBase, Store {
  Computed<int>? _$emomsCountComputed;

  @override
  int get emomsCount =>
      (_$emomsCountComputed ??= Computed<int>(() => super.emomsCount,
              name: 'EmomStateBase.emomsCount'))
          .value;
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout =>
      (_$workoutComputed ??= Computed<WorkoutSet>(() => super.workout,
              name: 'EmomStateBase.workout'))
          .value;
  Computed<WorkoutSettings>? _$settingsComputed;

  @override
  WorkoutSettings get settings =>
      (_$settingsComputed ??= Computed<WorkoutSettings>(() => super.settings,
              name: 'EmomStateBase.settings'))
          .value;

  late final _$EmomStateBaseActionController =
      ActionController(name: 'EmomStateBase', context: context);

  @override
  void setRounds(int emomIndex, int value) {
    final _$actionInfo = _$EmomStateBaseActionController.startAction(
        name: 'EmomStateBase.setRounds');
    try {
      return super.setRounds(emomIndex, value);
    } finally {
      _$EmomStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWorkTime(int emomIndex, Duration duration) {
    final _$actionInfo = _$EmomStateBaseActionController.startAction(
        name: 'EmomStateBase.setWorkTime');
    try {
      return super.setWorkTime(emomIndex, duration);
    } finally {
      _$EmomStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestAfterSet(int emomIndex, Duration duration) {
    final _$actionInfo = _$EmomStateBaseActionController.startAction(
        name: 'EmomStateBase.setRestAfterSet');
    try {
      return super.setRestAfterSet(emomIndex, duration);
    } finally {
      _$EmomStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addEmom() {
    final _$actionInfo = _$EmomStateBaseActionController.startAction(
        name: 'EmomStateBase.addEmom');
    try {
      return super.addEmom();
    } finally {
      _$EmomStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteEmom(int emomIndex) {
    final _$actionInfo = _$EmomStateBaseActionController.startAction(
        name: 'EmomStateBase.deleteEmom');
    try {
      return super.deleteEmom(emomIndex);
    } finally {
      _$EmomStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emomsCount: ${emomsCount},
workout: ${workout},
settings: ${settings}
    ''';
  }
}
