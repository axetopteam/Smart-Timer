import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/stores/amrap.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

import '../main.dart';

class AmrapPage extends StatelessWidget {
  AmrapPage({Key? key}) : super(key: key);

  final amrap = Amrap();

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
              'AMRAP',
              style: AppFonts.header,
            ),
            const SizedBox(height: 32),
            const Text(
              'As many rounds as possible in',
              style: AppFonts.header2,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Time:',
                  style: AppFonts.body,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await TimePicker.showTimePicker(
                      context,
                      initialValue: amrap.workTime.duration!,
                      timeRange: amrapWorkTimes,
                    );
                    if (selectedTime != null) {
                      amrap.setWorkTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer(
                      durationToString2(amrap.workTime.duration!),
                      width: 60,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),

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
                  // router.showTimer(amrap.workout);
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
