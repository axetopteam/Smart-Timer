// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_rest_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkRestState _$WorkRestStateFromJson(Map<String, dynamic> json) =>
    WorkRestState(
      roundsCount: json['roundsCount'] as int? ?? 10,
      ratio: (json['ratio'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$WorkRestStateToJson(WorkRestState instance) =>
    <String, dynamic>{
      'roundsCount': instance.roundsCount,
      'ratio': instance.ratio,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WorkRestState on WorkRestStateBase, Store {
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout =>
      (_$workoutComputed ??= Computed<WorkoutSet>(() => super.workout,
              name: 'WorkRestStateBase.workout'))
          .value;

  late final _$roundsCountAtom =
      Atom(name: 'WorkRestStateBase.roundsCount', context: context);

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

  late final _$ratioAtom =
      Atom(name: 'WorkRestStateBase.ratio', context: context);

  @override
  double get ratio {
    _$ratioAtom.reportRead();
    return super.ratio;
  }

  @override
  set ratio(double value) {
    _$ratioAtom.reportWrite(value, super.ratio, () {
      super.ratio = value;
    });
  }

  late final _$WorkRestStateBaseActionController =
      ActionController(name: 'WorkRestStateBase', context: context);

  @override
  void setRounds(int value) {
    final _$actionInfo = _$WorkRestStateBaseActionController.startAction(
        name: 'WorkRestStateBase.setRounds');
    try {
      return super.setRounds(value);
    } finally {
      _$WorkRestStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRatio(double value) {
    final _$actionInfo = _$WorkRestStateBaseActionController.startAction(
        name: 'WorkRestStateBase.setRatio');
    try {
      return super.setRatio(value);
    } finally {
      _$WorkRestStateBaseActionController.endAction(_$actionInfo);
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
