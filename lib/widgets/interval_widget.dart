import 'package:flutter/material.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/value_container.dart';

class IntervalWidget extends StatelessWidget {
  const IntervalWidget({
    Key? key,
    required this.title,
    required this.duration,
    required this.onTap,
    this.flex = 1,
  }) : super(key: key);

  final String title;
  final Duration? duration;
  final VoidCallback onTap;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: ValueContainer(
              duration != null ? durationToString2(duration!) : 'No cap',
            ),
          )
        ],
      ),
    );
  }
}
