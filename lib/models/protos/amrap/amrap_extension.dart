import 'amrap.pb.dart';

export 'amrap.pb.dart';

extension AmrapX on Amrap {
  Duration get workTime {
    return Duration(seconds: workDurationInSeconds);
  }

  Duration get restTime {
    return Duration(seconds: restDurationInSeconds);
  }

  static Amrap defaultValue = Amrap(workDurationInSeconds: 10 * 60, restDurationInSeconds: 2 * 60);

  Amrap copyWith({Duration? workTime, Duration? restTime}) {
    return Amrap(
      workTime: workTime ?? this.workTime,
      restTime: restTime ?? this.restTime,
    );
  }
}
