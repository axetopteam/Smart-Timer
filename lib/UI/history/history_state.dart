import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_timer/sdk/models/training_history_record.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

part 'history_state.g.dart';

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
    _isLoading = true;
    try {
      final response = await _sdk.fetchHistory(limit: _pageSize, offset: records.length);

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
    required DateTime finishAt,
    required String name,
    required String description,
    int? wellBeing,
    required WorkoutSettings workoutSettings,
    required TimerType timerType,
    required WorkoutResult result,
    required bool isFinished,
  }) async {
    final record = await _sdk.saveTrainingToHistory(
      finishAt: DateTime.now(),
      name: '',
      description: '',
      workoutSettings: workoutSettings,
      timerType: timerType,
      result: result,
      isFinished: isFinished,
    );
    records.insert(0, record);
  }
}
