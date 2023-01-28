enum TimerType {
  amrap,
  afap,
  emom,
  tabata,
  workRest,
  custom;

  String get readbleName {
    switch (this) {
      case TimerType.amrap:
        return 'Amrap';
      case TimerType.afap:
        return 'For Time';
      case TimerType.emom:
        return 'Emom';
      case TimerType.tabata:
        return 'Tabata';
      case TimerType.workRest:
        return 'Work : Rest';
      case TimerType.custom:
        return 'Custom';
    }
  }
}
