import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/workout/pause.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

part 'history_state.g.dart';

// ignore: library_private_types_in_public_api
class HistoryState = _HistoryState with _$HistoryState;

abstract class _HistoryState with Store {
  _HistoryState() {
    loadMore();
  }
  final _pageSize = 10;
  SdkService get _sdk => GetIt.I();

  @observable
  ObservableList<TrainingHistoryRecord> records = ObservableList();

  @observable
  bool canLoadMore = true;

  bool _isLoading = false;

  @observable
  Object? error;

  @action
  Future<void> loadMore({bool isRefresh = false}) async {
    if ((_isLoading || !canLoadMore) && !isRefresh) return;
    error = null;
    _isLoading = true;
    try {
      final response = await _sdk.fetchHistory(limit: _pageSize, offset: isRefresh ? 0 : records.length);

      if (isRefresh) {
        records = ObservableList.of(response);
      } else {
        records.addAll(response);
      }
      canLoadMore = response.length >= _pageSize;
    } catch (e) {
      error = e;
    } finally {
      _isLoading = false;
    }
  }

  @action
  Future<void> saveTraining({
    required DateTime startAt,
    required DateTime endAt,
    required String name,
    required String description,
    int? wellBeing,
    required WorkoutSettings workoutSettings,
    required TimerType timerType,
    required List<Interval> intervals,
    required List<Pause> pauses,
  }) async {
    final record = await _sdk.saveTrainingToHistory(
      startAt: startAt,
      endAt: endAt,
      name: '',
      description: '',
      workoutSettings: workoutSettings,
      timerType: timerType,
      intervals: intervals,
      pauses: pauses,
    );
    records.insert(0, record);
  }

  @action
  Future<void> updateRecord({required int id, String? name, String? description}) async {
    final updatedRecords = await _sdk.updateTainingHistoryRecord(
      id: id,
      name: name,
      description: description,
    );

    for (var record in updatedRecords) {
      final index = records.indexWhere((element) => element.id == record.id);
      if (index != -1) {
        records[index] = record;
      }
    }
  }

  @action
  Future<void> deleteRecord(int id) async {
    final index = records.indexWhere((element) => element.id == id);
    if (index != -1) {
      records.removeAt(index);
      await _sdk.deleteTrainingHistoryRecord(id);
    }
  }
}
