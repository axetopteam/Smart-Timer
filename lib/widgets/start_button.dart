import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key, required this.onPressed, this.backgroundColor}) : super(key: key);
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: context.buttonThemes.startButtonTheme,
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(backgroundColor)),
          onPressed: onPressed,
          child: const Text('Start'),
        ),
      ),
    );
  }
}
