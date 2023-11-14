import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

import '../timer_type.dart';

class CompletedState extends StatefulWidget {
  const CompletedState({required this.timerType, super.key});
  final TimerType timerType;
  // final WorkoutSet workout;

  @override
  State<CompletedState> createState() => _CompletedStateState();
}

class _CompletedStateState extends State<CompletedState> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Container(
          height: 180,
          width: 180,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.timerType.workoutColor(context),
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.checkmark_alt,
            size: 140,
            color: context.color.mainText,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          LocaleKeys.timer_completed_title.tr(),
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge,
        ),
        const SizedBox(height: 40),
        Expanded(flex: 2, child: _buildResult()),
        const SizedBox(height: 20),
        ElevatedButtonTheme(
          data: context.buttonThemes.popupButtonTheme,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(LocaleKeys.timer_completed_button.tr()),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildResult() {
    switch (widget.timerType) {
      case TimerType.afap:
      case TimerType.workRest:
      // return SingleChildScrollView(
      //   child: _buildSets(widget.workout),
      // );
      case TimerType.amrap:
      case TimerType.emom:
      case TimerType.tabata:
        return const SizedBox();
    }
  }

  // Widget _buildSets(WorkoutSet set) {
  //   final workIntervals = set.sets.map(
  //     (element) {
  //       if (element is WorkoutSet) {
  //         return element.sets
  //             .firstWhere((interval) => interval is WorkoutInterval && interval.type == IntervalType.work);
  //       }
  //     },
  //   );
  //   final intervals = <WorkoutInterval>[];
  //   for (var element in workIntervals) {
  //     if (element is WorkoutInterval) {
  //       intervals.add(element);
  //     }
  //   }
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: intervals
  //         .map(
  //           (e) => Text(e.duration?.durationToString(isCountdown: true) ?? ''),
  //         )
  //         .toList(),
  //   );
  // }
}
