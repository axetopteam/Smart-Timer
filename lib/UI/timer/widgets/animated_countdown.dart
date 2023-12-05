import 'package:flutter/cupertino.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/utils/duration.extension.dart';

class AnimatedCountdown extends StatefulWidget {
  const AnimatedCountdown({required this.duration, super.key});
  final Duration duration;

  @override
  State<AnimatedCountdown> createState() => _AnimatedCountdownState();
}

class _AnimatedCountdownState extends State<AnimatedCountdown> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1), reverseDuration: Duration.zero);
    final Animation<double> curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation = Tween<double>(begin: 1, end: 0).animate(curve);
    animateTo(widget.duration);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedCountdown oldWidget) {
    if (oldWidget.duration != widget.duration) {
      animateTo(widget.duration);
    }
    super.didUpdateWidget(oldWidget);
  }

  void animateTo(Duration duration) {
    final correctedDuration = duration - const Duration(milliseconds: 100);
    final value = 1 - (correctedDuration.inMilliseconds - 1000 * correctedDuration.inSeconds) / 1000;
    _controller.animateTo(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // print('#TESTAnimation# ${widget.duration}');

        return Opacity(
          opacity: _animation.value,
          child: Text(
            widget.duration.isSecondsCeil.toString(),
            style: context.textTheme.headlineSmall?.copyWith(fontSize: 100),
          ),
        );
      },
    );
  }
}
