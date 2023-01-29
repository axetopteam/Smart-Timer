import 'package:flutter/widgets.dart';

extension SeparatedWidgets on Iterable<Widget> {
  Iterable<Widget> addSeparator(Widget separator) {
    if (isEmpty) return this;
    final result = <Widget>[];
    for (var item in this) {
      result.addAll(
        [item, separator],
      );
    }
    return result..removeLast();
  }
}
