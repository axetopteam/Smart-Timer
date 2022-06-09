import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/app_theme/app_theme.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key, required this.onPressed, this.backgroundColor}) : super(key: key);
  final VoidCallback onPressed;
  final Color? backgroundColor;
  AppTheme get _theme => GetIt.I();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: ElevatedButtonTheme(
        data: _theme.startButtonTheme,
        child: ElevatedButton(
          child: const Text('Start'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
