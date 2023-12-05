import 'tabata.pb.dart';

export 'tabata.pb.dart';

extension TabataX on Tabata {
  Duration get workTime {
    return Duration(seconds: workTimeInSeconds);
  }

  Duration get restTime {
    return Duration(seconds: restTimeInSeconds);
  }

  Duration get restAfterSet {
    return Duration(seconds: restAfterSetInSeconds);
  }

  static Tabata defaultValue = Tabata(
    workTimeInSeconds: 20,
    restTimeInSeconds: 10,
    roundsCount: 8,
    restAfterSetInSeconds: 2 * 60,
  );

  Tabata copyWithNewValue({Duration? workTime, Duration? restTime, int? roundsCount, Duration? restAfterSet}) {
    return Tabata(
      workTimeInSeconds: (workTime ?? this.workTime).inSeconds,
      restTimeInSeconds: (restTime ?? this.restTime).inSeconds,
      roundsCount: roundsCount ?? this.roundsCount,
      restAfterSetInSeconds: (restAfterSet ?? this.restAfterSet).inSeconds,
    );
  }
}
