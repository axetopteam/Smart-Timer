import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/rounds_picker.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/stores/emom.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

class EmomPage extends StatelessWidget {
  EmomPage({Key? key}) : super(key: key);

  final emom = Emom();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            const Text(
              'EMOM',
              style: AppFonts.header,
            ),
            const SizedBox(height: 32),
            const Text(
              'Set your EMOM Timer',
              style: AppFonts.header2,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Every:',
                  style: AppFonts.body,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await TimePicker.showTimePicker(
                      context,
                      initialValue: emom.workTime.duration!,
                      timeRange: emomWorkTimes,
                    );
                    if (selectedTime != null) {
                      emom.setWorkTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer(
                      durationToString2(emom.workTime.duration!),
                      width: 60,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Rounds:',
                  style: AppFonts.body,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final selectedRounds = await RoundsPicker.showRoundsPicker(
                      context,
                      initialValue: emom.roundsCount,
                      range: tabataRounds,
                    );
                    if (selectedRounds != null) {
                      emom.setRounds(selectedRounds);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer('${emom.roundsCount}'),
                  ),
                )
              ],
            ),
            const Spacer(),
            // Text(
            //   'Total time: ${durationToString2(tabataSettings.totalTime)}',
            //   style: AppFonts.body,
            // ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MainButton(
                child: const Text(
                  'START TIMER',
                  style: AppFonts.buttonTitle,
                ),
                borderRadius: 20,
                onPressed: () {
                  // router.showTimer(emom.workout);
                },
                color: AppColors.accentBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
