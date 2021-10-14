import 'package:mobx/mobx.dart';
import 'package:smart_timer/models/round.dart';

class WorkoutSet {
  WorkoutSet(this.rounds);
  @observable
  final ObservableList<Round> rounds;
}
