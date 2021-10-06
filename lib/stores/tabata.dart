import 'package:mobx/mobx.dart';

part 'tabata.g.dart';

class TabataStore = TabataStoreBase with _$TabataStore;

abstract class TabataStoreBase with Store {
  @observable
  var rounds = 8;

  @observable
  var workTime = const Duration(seconds: 20);

  @observable
  var restTime = const Duration(seconds: 10);

  @computed
  Duration get totalTime => (workTime + restTime) * rounds;

  @computed
  List<Duration> get schedule {
    List<Duration> timing = [];
    for (int i = 0; i < rounds; i++) {
      timing.addAll([workTime, restTime]);
    }
    return timing;
  }

  @action
  void setRounds(int value) {
    rounds = value;
  }

  @action
  void setWorkTime(Duration value) {
    workTime = value;
  }

  @action
  void setRestTime(Duration value) {
    restTime = value;
  }
}
