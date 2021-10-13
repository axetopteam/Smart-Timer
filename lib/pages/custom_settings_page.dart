import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/rounds_picker.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/stores/custom_settings.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

class CustomSettingsPage extends StatelessWidget {
  CustomSettingsPage({Key? key}) : super(key: key);

  final customSettings = CustomSettings();

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
              'Custom',
              style: AppFonts.header,
            ),
            const SizedBox(height: 32),
            const Text(
              'Set your Custom Timer',
              style: AppFonts.header2,
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
                      initialValue: customSettings.roundsCount,
                      range: tabataRounds,
                    );
                    if (selectedRounds != null) {
                      customSettings.setRounds(selectedRounds);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer('${customSettings.roundsCount}'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Observer(builder: (ctx) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...customSettings.intervals.asMap().keys.map(
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Interval ${index + 1}:',
                                  style: AppFonts.body,
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () async {
                                    final selectedTime = await TimePicker.showTimePicker(
                                      context,
                                      initialValue: customSettings.intervals[index].duration!,
                                      timeRange: tabataWorkTimes,
                                    );
                                    if (selectedTime != null) {
                                      customSettings.setInterval(index, selectedTime);
                                    }
                                  },
                                  child: Observer(
                                    builder: (ctx) => ValueContainer(
                                      durationToString2(customSettings.intervals[index].duration!),
                                      width: 60,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    customSettings.deleteInterval(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    size: 28,
                                    color: AppColors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          customSettings.addInterval();
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 34,
                          color: AppColors.accentBlue,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Text(
            //   'Total time: ${durationToString2(customSettings.totalTime)}',
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
                  router.showTimer(customSettings.workout);
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
