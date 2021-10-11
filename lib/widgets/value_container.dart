import 'package:flutter/material.dart';
import 'package:smart_timer/application/application_theme.dart';

class ValueContainer extends StatelessWidget {
  const ValueContainer(
    this.value, {
    this.width = 30,
    Key? key,
  }) : super(key: key);

  final double width;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: AppFonts.body,
      ),
    );
  }
}
