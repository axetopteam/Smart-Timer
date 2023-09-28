import 'afap.pb.dart';

export 'afap.pb.dart';

extension AfapX on Afap {
  Duration get timeCap {
    return Duration(seconds: timeCapInSeconds);
  }

  Duration get restTime {
    return Duration(seconds: restTimeInSeconds);
  }

  static Afap defaultValue = Afap(
    timeCapInSeconds: 10 * 60,
    restTimeInSeconds: 2 * 60,
    noTimeCap: false,
  );

  Afap copyWithNewValue({Duration? timeCap, Duration? restTime, bool? noTimeCap}) {
    return Afap(
      timeCapInSeconds: (timeCap ?? this.timeCap).inSeconds,
      restTimeInSeconds: (restTime ?? this.restTime).inSeconds,
      noTimeCap: noTimeCap ?? this.noTimeCap,
    );
  }
}
