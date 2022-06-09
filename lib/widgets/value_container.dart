import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/core/app_theme/app_theme.dart';

class ValueContainer extends StatelessWidget {
  AppTheme get theme => GetIt.I();
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
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: theme.textTheme.headline2,
      ),
    );
  }
}
