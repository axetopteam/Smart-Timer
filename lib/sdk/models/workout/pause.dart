import 'package:smart_timer/sdk/models/unsuitable_type_error.dart';

class Pause {
  Pause({
    required this.startAt,
    this.endAt,
  });
  final DateTime startAt;
  final DateTime? endAt;

  bool get isEnded => endAt != null;

  Duration? get duration {
    return endAt?.toUtc().difference(startAt.toUtc());
  }

  Pause endPause(DateTime time) {
    return Pause(startAt: startAt, endAt: time);
  }

  factory Pause.fromJson(Map<String, dynamic> json) {
    final startAt =
        DateTime.fromMillisecondsSinceEpoch(json['startAt'] ?? (throw UnsuitableTypeError('startAt is null')));
    final endAt = json['endAt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['endAt']) : null;

    return Pause(
      startAt: startAt,
      endAt: endAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startAt': startAt.millisecondsSinceEpoch,
      'endAt': endAt?.millisecondsSinceEpoch,
    };
  }
}
