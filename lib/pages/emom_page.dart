import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/rounds_picker.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/routes/router_interface.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/stores/emom.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

class EmomPage extends StatefulWidget {
  EmomPage({Key? key}) : super(key: key);

  @override
  State<EmomPage> createState() => _EmomPageState();
}

class _EmomPageState extends State<EmomPage> {
  late final emom;

  @override
  void initState() {
    final settingsJson = getIt<AppProperties>().getEmomSettings();
    emom = settingsJson != null ? Emom.fromJson(settingsJson) : Emom();
    super.initState();
  }

  @override
  void dispose() {
    final json = emom.toJson();
    getIt<AppProperties>().setEmomSettings(json);
    super.dispose();
  }

  Widget buildSetsSettings(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Set's setting:",
          style: AppFonts.header2,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sets:',
              style: AppFonts.body,
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () async {
                final selectedRounds = await RoundsPicker.showRoundsPicker(
                  context,
                  initialValue: emom.setsCount,
                  range: tabataRounds,
                );
                if (selectedRounds != null) {
                  emom.setSetsCount(selectedRounds);
                }
              },
              child: Observer(
                builder: (ctx) => ValueContainer('${emom.setsCount}'),
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
                final selectedTime = await TimePicker.showTimePicker(
                  context,
                  initialValue: emom.restBetweenSets,
                  timeRange: tabataWorkTimes,
                );
                if (selectedTime != null) {
                  emom.setRestBetweenSets(selectedTime);
                }
              },
              child: Observer(
                builder: (ctx) => ValueContainer(
                  durationToString2(emom.restBetweenSets),
                  width: 60,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

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
                      initialValue: emom.workTime,
                      timeRange: emomWorkTimes,
                    );
                    if (selectedTime != null) {
                      emom.setWorkTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer(
                      durationToString2(emom.workTime),
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
            const SizedBox(height: 12),
            Observer(builder: (ctx) {
              return Column(
                children: [
                  if (emom.showSets) buildSetsSettings(context),
                  MainButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (emom.showSets)
                          const Icon(
                            Icons.delete_forever,
                            color: AppColors.red,
                          ),
                        if (!emom.showSets)
                          const Icon(
                            Icons.add_circle_outline,
                            color: AppColors.accentBlue,
                          ),
                        const SizedBox(width: 4),
                        Text(
                          emom.showSets ? 'Delete sets' : 'Add sets (optional)',
                          style: AppFonts.actionButton.copyWith(color: emom.showSets ? AppColors.red : AppColors.accentBlue),
                        ),
                      ],
                    ),
                    onPressed: () {
                      emom.toggleShowSets();
                    },
                    color: AppColors.transparent,
                  ),
                ],
              );
            }),
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
                  getIt.get<RouterInterface>().showTimer(emom.workout);
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
