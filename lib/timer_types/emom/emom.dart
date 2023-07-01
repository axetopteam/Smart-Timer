import 'package:json_annotation/json_annotation.dart';
part 'emom.g.dart';

@JsonSerializable()
class Emom {
  const Emom({
    required this.workTime,
    required this.roundsCount,
    required this.restAfterSet,
  });

  final Duration workTime;
  final int roundsCount;
  final Duration restAfterSet;

  static const defaultValue = Emom(
    workTime: Duration(minutes: 1),
    roundsCount: 10,
    restAfterSet: Duration(minutes: 2),
  );

  Emom copyWith({Duration? workTime, int? rounds, Duration? restAfterSet}) {
    return Emom(
      workTime: workTime ?? this.workTime,
      roundsCount: rounds ?? this.roundsCount,
      restAfterSet: restAfterSet ?? this.restAfterSet,
    );
  }

  Map<String, dynamic> toJson() => _$EmomToJson(this);

  factory Emom.fromJson(Map<String, dynamic> json) => _$EmomFromJson(json);
}
