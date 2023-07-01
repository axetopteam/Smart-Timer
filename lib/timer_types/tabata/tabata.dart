import 'package:json_annotation/json_annotation.dart';

part 'tabata.g.dart';

@JsonSerializable()
class Tabata {
  const Tabata({
    required this.workTime,
    required this.restTime,
    required this.roundsCount,
    required this.restAfterSet,
  });

  final Duration workTime;
  final Duration restTime;
  final int roundsCount;
  final Duration restAfterSet;

  static const defaultValue = Tabata(
    workTime: Duration(seconds: 20),
    restTime: Duration(seconds: 10),
    roundsCount: 8,
    restAfterSet: Duration(minutes: 2),
  );

  Tabata copyWith({
    Duration? workTime,
    Duration? restTime,
    int? roundsCount,
    Duration? restAfterSet,
  }) {
    return Tabata(
      workTime: workTime ?? this.workTime,
      restTime: restTime ?? this.restTime,
      roundsCount: roundsCount ?? this.roundsCount,
      restAfterSet: restAfterSet ?? this.restAfterSet,
    );
  }

  Map<String, dynamic> toJson() => _$TabataToJson(this);

  factory Tabata.fromJson(Map<String, dynamic> json) => _$TabataFromJson(json);
}
