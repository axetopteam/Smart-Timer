import 'package:flutter/widgets.dart';

extension SeparatedWidgets on Iterable<Widget> {
  List<Widget> addSeparator(Widget separator) {
    if (isEmpty) return toList();
    final result = <Widget>[];
    for (var item in this) {
      result.addAll(
        [item, separator],
      );
    }
    return result..removeLast();
  }
}
