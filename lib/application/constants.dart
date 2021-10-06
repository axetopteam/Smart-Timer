final tabataRounds = List.generate(119, (index) => index + 1, growable: false);
final tabataWorkTimes = List.generate(26, (index) => Duration(seconds: index + 5))
  ..addAll(
    List.generate(6, (index) => Duration(seconds: 30 + (index + 1) * 5)),
  );
// 