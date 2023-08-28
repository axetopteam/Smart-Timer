import 'package:flutter/widgets.dart';
import 'package:smart_timer/core/context_extension.dart';

import '../widgets/play_icon.dart';
import 'timer_status.dart';

class TimerProgressContainer extends StatefulWidget {
  const TimerProgressContainer({
    required this.color,
    required this.child,
    // required this.partOfHeight,
    required this.timerStatus,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final Color color;
  final Widget child;
  // final double partOfHeight;
  final TimerStatus timerStatus;
  final AnimationController controller;

  @override
  State<TimerProgressContainer> createState() => _TimerProgressContainerState();
}

class _TimerProgressContainerState extends State<TimerProgressContainer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      final height = constrains.maxHeight;
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return Container(
                height: height * widget.controller.value,
                decoration: BoxDecoration(
                  color: context.color.timerOverlayColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
            },
          ),
          widget.child,
          if (widget.timerStatus == TimerStatus.pause)
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
