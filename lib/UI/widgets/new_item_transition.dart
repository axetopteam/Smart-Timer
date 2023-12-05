import 'package:flutter/material.dart';

class NewItemTransition extends StatelessWidget {
  const NewItemTransition({
    required this.animation,
    required this.child,
    super.key,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
