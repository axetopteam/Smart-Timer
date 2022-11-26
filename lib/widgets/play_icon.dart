import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';

class PlayIcon extends StatelessWidget {
  const PlayIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle_filled_rounded,
      color: context.color.playIconColor,
      size: 90,
    );
  }
}
