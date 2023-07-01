import 'package:json_annotation/json_annotation.dart';

part 'afap.g.dart';

@JsonSerializable()
class Afap {
  const Afap({
    required this.timeCap,
    required this.restTime,
    required this.noTimeCap,
  });
  final Duration timeCap;
  final Duration restTime;
  final bool noTimeCap;

  static const defaultValue = Afap(
    timeCap: Duration(minutes: 10),
    restTime: Duration(minutes: 2),
    noTimeCap: false,
  );

  Afap copyWith({Duration? timeCap, Duration? restTime, bool? noTimeCap}) {
    return Afap(
      timeCap: timeCap ?? this.timeCap,
      restTime: restTime ?? this.restTime,
      noTimeCap: noTimeCap ?? this.noTimeCap,
    );
  }

  Map<String, dynamic> toJson() => _$AfapToJson(this);

  factory Afap.fromJson(Map<String, dynamic> json) => _$AfapFromJson(json);
}
