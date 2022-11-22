// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amrap_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AmrapState on AmrapStateBase, Store {
  Computed<int>? _$roundsCoundComputed;

  @override
  int get roundsCound =>
      (_$roundsCoundComputed ??= Computed<int>(() => super.roundsCound,
              name: 'AmrapStateBase.roundsCound'))
          .value;
  Computed<WorkoutSet>? _$workoutComputed;

  @override
  WorkoutSet get workout =>
      (_$workoutComputed ??= Computed<WorkoutSet>(() => super.workout,
              name: 'AmrapStateBase.workout'))
          .value;

  late final _$roundsAtom =
      Atom(name: 'AmrapStateBase.rounds', context: context);

  @override
  ObservableList<ObservableList<Duration>> get rounds {
    _$roundsAtom.reportRead();
    return super.rounds;
  }

  @override
  set rounds(ObservableList<ObservableList<Duration>> value) {
    _$roundsAtom.reportWrite(value, super.rounds, () {
      super.rounds = value;
    });
  }

  late final _$AmrapStateBaseActionController =
      ActionController(name: 'AmrapStateBase', context: context);

  @override
  void addRound() {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.addRound');
    try {
      return super.addRound();
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRound(int roundIndex) {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.deleteRound');
    try {
      return super.deleteRound(roundIndex);
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInterval(int roundIndex, int intervalIndex, Duration duration) {
    final _$actionInfo = _$AmrapStateBaseActionController.startAction(
        name: 'AmrapStateBase.setInterval');
    try {
      return super.setInterval(roundIndex, intervalIndex, duration);
    } finally {
      _$AmrapStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rounds: ${rounds},
roundsCound: ${roundsCound},
workout: ${workout}
    ''';
  }
}
