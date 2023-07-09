import 'package:json_annotation/json_annotation.dart';

part 'amrap.g.dart';

@JsonSerializable()
class Amrap {
  const Amrap({
    required this.workTime,
    required this.restTime,
  });
  final Duration workTime;
  final Duration restTime;

  static const defaultValue = Amrap(
    workTime: Duration(minutes: 10),
    restTime: Duration(minutes: 2),
  );

  Amrap copyWith({Duration? workTime, Duration? restTime}) {
    return Amrap(
      workTime: workTime ?? this.workTime,
      restTime: restTime ?? this.restTime,
    );
  }

  Map<String, dynamic> toJson() => _$AmrapToJson(this);

  factory Amrap.fromJson(Map<String, dynamic> json) => _$AmrapFromJson(json);
}
