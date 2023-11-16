// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryState on _HistoryState, Store {
  late final _$recordsAtom =
      Atom(name: '_HistoryState.records', context: context);

  @override
  ObservableList<TrainingHistoryRecord> get records {
    _$recordsAtom.reportRead();
    return super.records;
  }

  @override
  set records(ObservableList<TrainingHistoryRecord> value) {
    _$recordsAtom.reportWrite(value, super.records, () {
      super.records = value;
    });
  }

  late final _$canLoadMoreAtom =
      Atom(name: '_HistoryState.canLoadMore', context: context);

  @override
  bool get canLoadMore {
    _$canLoadMoreAtom.reportRead();
    return super.canLoadMore;
  }

  @override
  set canLoadMore(bool value) {
    _$canLoadMoreAtom.reportWrite(value, super.canLoadMore, () {
      super.canLoadMore = value;
    });
  }

  late final _$errorAtom = Atom(name: '_HistoryState.error', context: context);

  @override
  Object? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Object? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadMoreAsyncAction =
      AsyncAction('_HistoryState.loadMore', context: context);

  @override
  Future<void> loadMore({bool isRefresh = false}) {
    return _$loadMoreAsyncAction
        .run(() => super.loadMore(isRefresh: isRefresh));
  }

  late final _$saveTrainingAsyncAction =
      AsyncAction('_HistoryState.saveTraining', context: context);

  @override
  Future<void> saveTraining(
      {required DateTime startAt,
      required DateTime endAt,
      required String name,
      required String description,
      int? wellBeing,
      required WorkoutSettings workoutSettings,
      required TimerType timerType,
      required List<Interval> intervals,
      required List<Pause> pauses}) {
    return _$saveTrainingAsyncAction.run(() => super.saveTraining(
        startAt: startAt,
        endAt: endAt,
        name: name,
        description: description,
        wellBeing: wellBeing,
        workoutSettings: workoutSettings,
        timerType: timerType,
        intervals: intervals,
        pauses: pauses));
  }

  @override
  String toString() {
    return '''
records: ${records},
canLoadMore: ${canLoadMore},
error: ${error}
    ''';
  }
}
