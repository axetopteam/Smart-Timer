import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';

class TimePicker extends StatefulWidget {
  static Future<Duration?> showTimePicker(
    BuildContext context, {
    required Duration? initialValue,
    required List<Duration?> timeRange,
  }) {
    return showCupertinoModalPopup<Duration>(
      context: context,
      builder: (ctx) => TimePicker(
        initialValue: initialValue,
        timeRange: timeRange,
      ),
    );
  }

  const TimePicker({
    Key? key,
    required this.initialValue,
    required this.timeRange,
  }) : super(key: key);

  final Duration? initialValue;
  final List<Duration?> timeRange;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late int selectedIndex;

  late final FixedExtentScrollController _controller;

  @override
  void initState() {
    selectedIndex = widget.timeRange.indexOf(widget.initialValue);
    _controller = FixedExtentScrollController(initialItem: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeOffset = MediaQuery.of(context).viewPadding;
    final bottomPadding = max(safeOffset.bottom, 34.0);

    return Container(
      color: CupertinoColors.systemGrey5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              useMagnifier: true,
              magnification: 1.2,
              backgroundColor: CupertinoColors.systemGrey5,
              scrollController: _controller,
              children: widget.timeRange
                  .map(
                    (time) => Center(
                      child: Text(
                        time == null ? 'No time cap' : durationToString2(time),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .toList(),
              onSelectedItemChanged: (value) {
                selectedIndex = value;
              },
              itemExtent: 40,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MainButton(
              child: const Text(
                'Ok',
                style: AppFonts.buttonTitle,
              ),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                Navigator.of(context).pop(widget.timeRange[selectedIndex]);
              },
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
