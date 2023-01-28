import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_timer/bottom_sheets/time_picker/timer_picker_state.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/utils/constans.dart';

final minutesList = List.generate(60, (index) => index);
final secondsList = List.generate(12, (index) => 5 * index);

class TimePicker extends StatefulWidget {
  static Future<Duration?> showTimePicker(
    BuildContext context, {
    Duration? initialDuration,
    bool showNoCap = false,
  }) {
    return showCupertinoModalBottomSheet<Duration?>(
      context: context,
      topRadius: const Radius.circular(20),
      builder: (ctx) => TimePicker(
        initialDuration: initialDuration ?? Duration.zero,
        showNoCap: showNoCap,
      ),
    );
  }

  const TimePicker({
    Key? key,
    required this.initialDuration,
    this.showNoCap = false,
  }) : super(key: key);

  final Duration initialDuration;
  final bool showNoCap;

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
      secondsList: List.generate(12, (index) => 5 * index),
    );

    _minutesController = FixedExtentScrollController(initialItem: state.minutesIndex!);
    _secondsController = FixedExtentScrollController(initialItem: state.secondsIndex!);
    super.initState();
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
            'Work',
            style: context.textTheme.headline3,
          ),
          const Spacer(),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  child: Observer(builder: (context) {
                    return IgnorePointer(
                      ignoring: state.noTimeCap,
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
                              padding: const EdgeInsets.only(left: 50),
                              child: Text(
                                'm',
                                style: context.textTheme.headline4,
                              ),
                            ),
                          ),
                        ),
                        children: state.minutesList
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
                        onSelectedItemChanged: (value) {
                          state.minutesIndex = value;
                        },
                        itemExtent: 70,
                      ),
                    );
                  }),
                ),
                Observer(builder: (context) {
                  return Expanded(
                    child: IgnorePointer(
                      ignoring: state.noTimeCap,
                      ignoringSemantics: false,
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
                                's',
                                style: context.textTheme.headline4,
                              ),
                            ),
                          ),
                        ),
                        children: state.secondsList
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
                        onSelectedItemChanged: (value) {
                          state.secondsIndex = value;
                        },
                        itemExtent: 70,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          if (widget.showNoCap)
            Expanded(
              child: Material(
                color: context.color.bottomSheetBackgroundColor,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: state.noTimeCap,
                            onChanged: (value) {
                              if (value != null) {
                                state.noTimeCap = value;
                              }
                            }),
                        const Text('No time cap'),
                      ],
                    );
                  }),
                ),
              ),
            ),
          if (!widget.showNoCap) const Spacer(),
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
                  final Duration? duration;
                  if (!state.noTimeCap) {
                    final minutes = state.minutes;
                    final seconds = state.seconds;
                    if (minutes != null && seconds != null) {
                      duration = Duration(minutes: minutes, seconds: seconds);
                    } else {
                      duration = null;
                    }
                  } else {
                    duration = noTimeCapDuration;
                  }

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
