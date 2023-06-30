import 'package:flutter/widgets.dart';
import 'package:smart_timer/core/context_extension.dart';

import '../widgets/play_icon.dart';
import 'timer_status.dart';

class TimerProgressContainer extends StatelessWidget {
  const TimerProgressContainer({
    required this.color,
    required this.child,
    required this.partOfHeight,
    required this.timerStatus,
    Key? key,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final double partOfHeight;
  final TimerStatus timerStatus;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      final height = constrains.maxHeight;
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            height: height * partOfHeight,
            decoration: BoxDecoration(
              color: context.color.timerOverlayColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          child,
          if (timerStatus == TimerStatus.pause)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.color.pauseOverlayColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const PlayIcon(),
            )
        ],
      );
    });
  }
}
