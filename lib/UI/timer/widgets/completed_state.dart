import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/UI/history/widgets/workout_result.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/sdk/models/training_history_record.dart';

import '../timer_type.dart';

class CompletedState extends StatefulWidget {
  const CompletedState({required this.timerType, this.result, super.key});
  final TimerType timerType;
  final TrainingHistoryRecord? result;

  @override
  State<CompletedState> createState() => _CompletedStateState();
}

class _CompletedStateState extends State<CompletedState> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  height: 160,
                  width: 160,
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
                const SizedBox(height: 30),
                Text(
                  LocaleKeys.timer_completed_title.tr(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.displaySmall,
                ),
                const SizedBox(height: 40),
                _buildResult(),
              ],
            ),
          ),
        ),
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
    if (widget.result != null) {
      return Column(
        children: [
          WorkoutResult(widget.result!),
        ],
      );
    }
    return const SizedBox();
  }
}
