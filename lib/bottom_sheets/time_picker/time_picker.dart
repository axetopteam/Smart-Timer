import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/bottom_sheets/time_picker/timer_picker_state.dart';
import 'package:smart_timer/core/context_extension.dart';

final minutesList = List.generate(60, (index) => index);
final secondsList = List.generate(60, (index) => index);

class TimePicker extends StatefulWidget {
  static Future<Duration?> showTimePicker(
    BuildContext context, {
    Duration? initialDuration,
  }) {
    return showCupertinoModalPopup<Duration>(
      context: context,
      builder: (ctx) => TimePicker(
        initialDuration: initialDuration,
      ),
    );
  }

  const TimePicker({
    Key? key,
    Duration? initialDuration,
  })  : initialValue = initialDuration ?? Duration.zero,
        super(key: key);

  final Duration initialValue;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late final FixedExtentScrollController _minutesController;
  late final FixedExtentScrollController _secondsController;

  final state = TimerPickerState();

  @override
  void initState() {
    // selectedIndex = widget.timeRange.indexOf(widget.initialValue);
    final minutes = widget.initialValue.inMinutes;
    final seconds = widget.initialValue.inSeconds - minutes * 60;

    _minutesController = FixedExtentScrollController(initialItem: minutes);
    _secondsController = FixedExtentScrollController(initialItem: seconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final safeOffset = mq.viewPadding;
    final bottomPadding = max(safeOffset.bottom, 34.0);
    final topPadding = max(safeOffset.top, 34.0) + 10;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: context.color.bottomSheetBackgroundColor,
        ),
        child: Column(
          children: [
            SizedBox(height: topPadding),
            Text(
              'Work',
              style: context.textTheme.headline3,
            ),
            const Spacer(),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      useMagnifier: true,
                      magnification: 1,
                      diameterRatio: 20,
                      scrollController: _minutesController,
                      selectionOverlay: Center(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 48),
                            child: Text(
                              'm',
                              style: context.textTheme.headline4,
                            ),
                          ),
                        ),
                      ),
                      children: minutesList
                          .map(
                            (minutes) => Center(
                              child: Text(
                                '$minutes',
                                textAlign: TextAlign.center,
                                style: context.textTheme.headline4,
                              ),
                            ),
                          )
                          .toList(),
                      onSelectedItemChanged: (value) {},
                      itemExtent: 70,
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      useMagnifier: true,
                      magnification: 1,
                      diameterRatio: 20,
                      scrollController: _secondsController,
                      selectionOverlay: Center(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 42),
                            child: Text(
                              's',
                              style: context.textTheme.headline4,
                            ),
                          ),
                        ),
                      ),
                      children: secondsList
                          .map(
                            (seconds) => Center(
                              child: Text(
                                '$seconds',
                                textAlign: TextAlign.center,
                                style: context.textTheme.headline4,
                              ),
                            ),
                          )
                          .toList(),
                      onSelectedItemChanged: (value) {},
                      itemExtent: 70,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButtonTheme(
                data: context.buttonThemes.popupButtonTheme,
                child: ElevatedButton(
                  child: const Text(
                    'Confirm Time',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(Duration(
                      minutes: _minutesController.selectedItem,
                      seconds: _secondsController.selectedItem,
                    ));
                  },
                ),
              ),
            ),
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }
}
