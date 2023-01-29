import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';

class ValueContainer extends StatelessWidget {
  const ValueContainer(
    this.value, {
    Key? key,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: context.color.borderColor),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyText1,
      ),
    );
  }
}
