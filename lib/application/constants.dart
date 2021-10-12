final tabataRounds = List.generate(119, (index) => index + 1, growable: false);
final tabataWorkTimes = List.generate(26, (index) => Duration(seconds: 5 + index))
  ..addAll(
    [
      ...List.generate(6, (index) => Duration(seconds: 30 + (index + 1) * 5)),
      ...List.generate(42, (index) => Duration(seconds: 60 + (index + 1) * 10)),
      ...List.generate(8, (index) => Duration(minutes: 8, seconds: (index + 1) * 15)),
      ...List.generate(5, (index) => Duration(minutes: 10, seconds: (index + 1) * 60)),
    ],
  );

final emomWorkTimes = List.generate(3, (index) => Duration(seconds: 10 + index * 10))
  ..addAll(
    [
      ...List.generate(10, (index) => Duration(seconds: 30 + (index + 1) * 15)),
      ...List.generate(4, (index) => Duration(minutes: 3, seconds: (index + 1) * 30)),
      ...List.generate(95, (index) => Duration(minutes: 6 + index)),
    ],
  );

final amrapWorkTimes = List<Duration>.from([
  const Duration(seconds: 20),
  const Duration(seconds: 30),
])
  ..addAll(
    [
      ...List.generate(10, (index) => Duration(seconds: 45 + index * 15)), //0:45 ... 3:00
      ...List.generate(4, (index) => Duration(minutes: 3, seconds: (index + 1) * 30)), //3:30 ... 5:00
      ...List.generate(95, (index) => Duration(minutes: 6 + index)), // 6:00 .. 100:00
    ],
  );

final afapWorkTimes = List<Duration?>.from([null])..addAll(List.generate(100, (index) => Duration(minutes: 1 + index)));
