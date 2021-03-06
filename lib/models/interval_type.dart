enum IntervalType { countdown, work, rest }

extension IntervalTypeString on IntervalType {
  String get desc {
    switch (this) {
      case IntervalType.countdown:
        return 'Countdown';
      case IntervalType.work:
        return 'Work';
      case IntervalType.rest:
        return 'Rest';
    }
  }
}
