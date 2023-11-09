import 'work_rest.pb.dart';

export 'work_rest.pb.dart';

extension WorkRestX on WorkRest {
  static WorkRest defaultValue = WorkRest(
    roundsCount: 10,
    ratio: 1,
  );

  Duration get restAfterSet {
    return Duration(seconds: restAfterSetInSeconds);
  }

  WorkRest copyWithNewValue({int? roundsCount, double? ratio}) {
    return WorkRest(
      roundsCount: roundsCount ?? this.roundsCount,
      ratio: ratio ?? this.ratio,
    );
  }
}
