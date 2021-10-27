import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/stores/afap.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

class AfapPage extends StatelessWidget {
  AfapPage({Key? key}) : super(key: key);

  final afap = Afap();

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
              'FOR TIME',
              style: AppFonts.header,
            ),
            const SizedBox(height: 32),
            const Text(
              'As fast as possible for time',
              style: AppFonts.header2,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Time cap:',
                  style: AppFonts.body,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await TimePicker.showTimePicker(
                      context,
                      initialValue: afap.workTime.duration!,
                      timeRange: afapWorkTimes,
                    );

                    afap.setTimeCap(selectedTime);
                  },
                  child: Observer(builder: (ctx) {
                    final duration = afap.workTime.duration;
                    return ValueContainer(
                      duration != null ? durationToString2(duration) : 'None',
                      width: 60,
                    );
                  }),
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
                  final workout = afap.workout;
                  router.showTimer(afap.workout);
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
