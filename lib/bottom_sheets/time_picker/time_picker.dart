import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_timer/bottom_sheets/time_picker/timer_picker_state.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

final minutesList = List.generate(60, (index) => index);
final secondsList = List.generate(12, (index) => 5 * index);

class TimePicker extends StatefulWidget {
  static Future<Duration?> showTimePicker(
    BuildContext context, {
    required String title,
    Duration? initialDuration,
    Duration? minDuration,
  }) {
    return showCupertinoModalBottomSheet<Duration?>(
      context: context,
      topRadius: const Radius.circular(20),
      builder: (ctx) => TimePicker(
        title: title,
        initialDuration: initialDuration ?? Duration.zero,
        minDuration: minDuration,
      ),
    );
  }

  const TimePicker({
    Key? key,
    required this.title,
    required this.initialDuration,
    Duration? minDuration,
  })  : minDuration = minDuration ?? const Duration(seconds: 5),
        super(key: key);

  final String title;
  final Duration initialDuration;
  final Duration minDuration;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late final FixedExtentScrollController _minutesController;
  late final FixedExtentScrollController _secondsController;

  late final TimerPickerState state;

  @override
  void initState() {
    state = TimerPickerState(
      initialDuration: widget.initialDuration,
      minutesList: minutesList,
      secondsList: secondsList,
    );

    _minutesController = FixedExtentScrollController(initialItem: state.minutesIndex);
    _secondsController = FixedExtentScrollController(initialItem: state.secondsIndex);
    _minutesController.addListener(_checkMinimulDuration);
    _secondsController.addListener(_checkMinimulDuration);

    super.initState();
  }

  @override
  void dispose() {
    _minutesController.removeListener(_checkMinimulDuration);
    _secondsController.removeListener(_checkMinimulDuration);
    _minutesController.dispose();
    _secondsController.dispose();

    super.dispose();
  }

  void _checkMinimulDuration() {
    final minDuration = widget.minDuration;
    final minutes = state.minutes;
    final seconds = state.seconds;
    final currentDuration = Duration(minutes: minutes, seconds: seconds);
    if (currentDuration < minDuration) {
      final newDuration = minDuration;
      state.setDuration(newDuration);
      _minutesController.animateToItem(state.minutes,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

      _secondsController.animateToItem(state.secondsIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final safeOffset = mq.viewPadding;
    final bottomPadding = max(safeOffset.bottom, 34.0);

    return Container(
      height: mq.size.height * 0.8,
      decoration: BoxDecoration(
        color: context.color.bottomSheetBackgroundColor,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: context.textTheme.displaySmall,
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
                        color: context.color.pickerOverlay,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text(
                            LocaleKeys.minute_shortest.tr(),
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    onSelectedItemChanged: (value) {
                      state.minutesIndex = value;
                    },
                    itemExtent: 70,
                    children: state.minutesList
                        .map(
                          (minutes) => Center(
                            child: Text(
                              '$minutes',
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineMedium,
                            ),
                          ),
                        )
                        .toList(),
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
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 44),
                          child: Text(
                            LocaleKeys.second_shortest.tr(),
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    onSelectedItemChanged: (value) {
                      state.secondsIndex = value;
                    },
                    itemExtent: 70,
                    children: state.secondsList
                        .map(
                          (seconds) => Center(
                            child: Text(
                              '$seconds',
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineMedium,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButtonTheme(
              data: context.buttonThemes.popupButtonTheme,
              child: ElevatedButton(
                child: Text(
                  LocaleKeys.confirm.tr(),
                ),
                onPressed: () {
                  final Duration? duration;
                  final minutes = state.minutes;
                  final seconds = state.seconds;
                  duration = Duration(minutes: minutes, seconds: seconds);

                  Navigator.of(context).pop(duration);
                },
              ),
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
