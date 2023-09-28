import 'emom.pb.dart';

export 'emom.pb.dart';

extension EmomX on Emom {
  Duration get workTime {
    return Duration(seconds: workTimeInSeconds);
  }

  Duration get restAfterSet {
    return Duration(seconds: restAfterSetInSeconds);
  }

  static Emom defaultValue = Emom(
    workTimeInSeconds: 1 * 60,
    roundsCount: 10,
    restAfterSetInSeconds: 1 * 60,
  );

  Emom copyWithNewValue({Duration? workTime, int? roundsCount, Duration? restAfterSet}) {
    return Emom(
      workTimeInSeconds: (workTime ?? this.workTime).inSeconds,
      roundsCount: roundsCount ?? this.roundsCount,
      restAfterSetInSeconds: (restAfterSet ?? this.restAfterSet).inSeconds,
    );
  }
}
