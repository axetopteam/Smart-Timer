// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'afap_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AfapState on AfapStateBase, Store {
  Computed<int>? _$afapsCountComputed;

  @override
  int get afapsCount =>
      (_$afapsCountComputed ??= Computed<int>(() => super.afapsCount,
              name: 'AfapStateBase.afapsCount'))
          .value;
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout =>
      (_$workoutComputed ??= Computed<WorkoutSet>(() => super.workout,
              name: 'AfapStateBase.workout'))
          .value;
  Computed<WorkoutSettings>? _$settingsComputed;

  @override
  WorkoutSettings get settings =>
      (_$settingsComputed ??= Computed<WorkoutSettings>(() => super.settings,
              name: 'AfapStateBase.settings'))
          .value;

  late final _$AfapStateBaseActionController =
      ActionController(name: 'AfapStateBase', context: context);

  @override
  void setTimeCap(int afapIndex, Duration duration) {
    final _$actionInfo = _$AfapStateBaseActionController.startAction(
        name: 'AfapStateBase.setTimeCap');
    try {
      return super.setTimeCap(afapIndex, duration);
    } finally {
      _$AfapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRestTime(int afapIndex, Duration duration) {
    final _$actionInfo = _$AfapStateBaseActionController.startAction(
        name: 'AfapStateBase.setRestTime');
    try {
      return super.setRestTime(afapIndex, duration);
    } finally {
      _$AfapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNoTimeCap(int afapIndex, bool noTimeCap) {
    final _$actionInfo = _$AfapStateBaseActionController.startAction(
        name: 'AfapStateBase.setNoTimeCap');
    try {
      return super.setNoTimeCap(afapIndex, noTimeCap);
    } finally {
      _$AfapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAfap() {
    final _$actionInfo = _$AfapStateBaseActionController.startAction(
        name: 'AfapStateBase.addAfap');
    try {
      return super.addAfap();
    } finally {
      _$AfapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteAfap(int afapIndex) {
    final _$actionInfo = _$AfapStateBaseActionController.startAction(
        name: 'AfapStateBase.deleteAfap');
    try {
      return super.deleteAfap(afapIndex);
    } finally {
      _$AfapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
afapsCount: ${afapsCount},
workout: ${workout},
settings: ${settings}
    ''';
  }
}
