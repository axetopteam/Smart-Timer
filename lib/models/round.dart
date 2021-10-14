import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import 'interval.dart';

class Round {
  Round(this.intervals);
  @observable
  final ObservableList<Interval> intervals;
}
