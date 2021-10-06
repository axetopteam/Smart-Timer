import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/application/application_theme.dart';

class MainButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final Color disabledColor;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;

  const MainButton({
    required this.child,
    this.onPressed,
    this.color = AppColors.white,
    this.borderRadius = 10,
    this.disabledColor = AppColors.gray5,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color,
      padding: padding,
      onPressed: onPressed,
      disabledColor: disabledColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
