// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_rest_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorkRestState on WorkRestStateBase, Store {
  Computed<WorkoutSettings>? _$settingsComputed;

  @override
  WorkoutSettings get settings =>
      (_$settingsComputed ??= Computed<WorkoutSettings>(() => super.settings,
              name: 'WorkRestStateBase.settings'))
          .value;

  late final _$WorkRestStateBaseActionController =
      ActionController(name: 'WorkRestStateBase', context: context);

  @override
  void setRounds(int setIndex, int value) {
    final _$actionInfo = _$WorkRestStateBaseActionController.startAction(
        name: 'WorkRestStateBase.setRounds');
    try {
      return super.setRounds(setIndex, value);
    } finally {
      _$WorkRestStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRatio(int setIndex, double value) {
    final _$actionInfo = _$WorkRestStateBaseActionController.startAction(
        name: 'WorkRestStateBase.setRatio');
    try {
      return super.setRatio(setIndex, value);
    } finally {
      _$WorkRestStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
settings: ${settings}
    ''';
  }
}
