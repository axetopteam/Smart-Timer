import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_timer/core/app_theme/theme.dart';

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    this.height = 40,
    super.key,
  });
  final double height;

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contrains) {
        final maxX = contrains.maxWidth;

        return GestureDetector(
          onPanUpdate: (details) {
            final dx = details.localPosition.dx;
            print('$dx/$maxX');
            controller.animateTo(max(dx / maxX, 1.0));
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                height: widget.height,
                decoration:
                    BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(widget.height / 2)),
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (ctx, child) => Positioned(
                  left: controller.value * maxX,
                  child: child ?? const SizedBox(),
                ),
                child: Container(
                  height: widget.height + 12,
                  width: widget.height + 12,
                  decoration: BoxDecoration(
                    color: AppColors.denimBlue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
