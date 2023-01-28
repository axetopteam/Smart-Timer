enum IntervalType {
  countdown,
  work,
  rest;

  String get desc {
    switch (this) {
      case IntervalType.countdown:
        return '';
      case IntervalType.work:
        return 'Work';
      case IntervalType.rest:
        return 'Rest';
    }
  }
}
