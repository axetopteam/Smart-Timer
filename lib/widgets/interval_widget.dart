import 'package:flutter/cupertino.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/value_container.dart';

class IntervalWidget extends StatelessWidget {
  const IntervalWidget({
    Key? key,
    required this.title,
    required this.duration,
    this.onTap,
    this.canBeUnlimited = false,
    this.onNoTimeCapChanged,
    this.flex = 1,
  }) : super(key: key);

  final String title;
  final Duration? duration;
  final VoidCallback? onTap;
  final int flex;
  final bool canBeUnlimited;
  final ValueChanged<bool?>? onNoTimeCapChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: ValueContainer(
              duration != null ? durationToString2(duration!) : 'No cap',
            ),
          ),
          if (canBeUnlimited)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Transform.translate(
                offset: const Offset(-10, 0),
                child: GestureDetector(
                  child: Row(
                    children: [
                      CupertinoCheckbox(
                        value: duration == null,
                        onChanged: onNoTimeCapChanged,
                      ),
                      const Text('No time cap'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
