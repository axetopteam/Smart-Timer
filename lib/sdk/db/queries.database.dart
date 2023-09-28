import 'package:drift/drift.dart';
import 'package:smart_timer/timer/timer_type.dart';

import 'database.dart';

extension DatabaseQueries on AppDatabase {
  Future<WorkoutSettings?> lastWorkoutFor(TimerType timerType) {
    return (select(workoutsHistory)
          ..where((t) => t.workout.regexp('${timerType.hexCode}*'))
          ..orderBy([(t) => OrderingTerm(expression: t.endAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> addWorkoutToHistory({
    required String workout,
    required DateTime endAt,
    required String description,
  }) {
    final entry = WorkoutsHistoryCompanion.insert(
      workout: workout,
      endAt: endAt.millisecondsSinceEpoch,
      description: description,
    );
    return into(workoutsHistory).insert(entry);
  }
}
