import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/rounds_picker.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/pages/timer_page.dart';
import 'package:smart_timer/stores/tabata.dart';
import 'package:smart_timer/stores/timer_store.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';

class TabataSettingsPage extends StatelessWidget {
  TabataSettingsPage({Key? key}) : super(key: key);

  final tabataSettings = TabataStore();

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
              'TABATA',
              style: AppFonts.header,
            ),
            const SizedBox(height: 32),
            const Text(
              'Set your Tabata Timer',
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
                      initialValue: tabataSettings.rounds,
                      range: tabataRounds,
                    );
                    if (selectedRounds != null) {
                      tabataSettings.setRounds(selectedRounds);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => buildBorderContainer('${tabataSettings.rounds}'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Work:',
                  style: AppFonts.body,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await TimePicker.showRoundsPicker(
                      context,
                      initialValue: tabataSettings.workTime.duration,
                      timeRange: tabataWorkTimes,
                    );
                    if (selectedTime != null) {
                      tabataSettings.setWorkTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => buildBorderContainer(
                      durationToString2(tabataSettings.workTime.duration),
                      width: 60,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Rest:',
                  style: AppFonts.body,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await TimePicker.showRoundsPicker(
                      context,
                      initialValue: tabataSettings.restTime.duration,
                      timeRange: tabataWorkTimes,
                    );
                    if (selectedTime != null) {
                      tabataSettings.setRestTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => buildBorderContainer(
                      durationToString2(tabataSettings.restTime.duration),
                      width: 60,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              'Total time: ${durationToString2(tabataSettings.totalTime)}',
              style: AppFonts.body,
            ),
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
                  router.showTabataTimer(tabataSettings.schedule);
                },
                color: AppColors.accentBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildBorderContainer(String value, {double width = 30}) {
    return Container(
      width: width,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          top: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: AppFonts.body,
      ),
    );
  }
}
