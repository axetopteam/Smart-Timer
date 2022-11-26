import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/bottom_sheets/rounds_picker.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/pages/workout_desc.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

import 'tabata_state.dart';

class TabataPage extends StatefulWidget {
  const TabataPage({Key? key}) : super(key: key);

  @override
  State<TabataPage> createState() => _TabataPageState();
}

class _TabataPageState extends State<TabataPage> {
  late final TabataState tabataSettings;

  @override
  void initState() {
    final settingsJson = GetIt.I<AppProperties>().getTabataSettings();
    tabataSettings = TabataState.fromJson(settingsJson);
    super.initState();
  }

  @override
  dispose() {
    final json = tabataSettings.toJson();
    GetIt.I<AppProperties>().setTabataSettings(json);
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
                  initialValue: tabataSettings.setsCount,
                  range: tabataRounds,
                );
                if (selectedRounds != null) {
                  tabataSettings.setSetsCount(selectedRounds);
                }
              },
              child: Observer(
                builder: (ctx) => ValueContainer('${tabataSettings.setsCount}'),
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
                  initialDuration: tabataSettings.restBetweenSets.duration!,
                );
                if (selectedTime != null) {
                  tabataSettings.setRestBetweenSets(selectedTime);
                }
              },
              child: Observer(
                builder: (ctx) => ValueContainer(
                  durationToString2(tabataSettings.restBetweenSets.duration!),
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
              'TABATA',
              style: AppFonts.header,
            ),
            TextButton(
              child: Text(
                'Show description',
                style: AppFonts.buttonTitle.copyWith(color: AppColors.accentBlue),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return WorkoutDesc(tabataSettings.workout);
                }));
              },
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
                      initialValue: tabataSettings.roundsCount,
                      range: tabataRounds,
                    );
                    if (selectedRounds != null) {
                      tabataSettings.setRounds(selectedRounds);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer('${tabataSettings.roundsCount}'),
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
                    final selectedTime = await TimePicker.showTimePicker(
                      context,
                      initialDuration: tabataSettings.workTime.duration!,
                    );
                    if (selectedTime != null) {
                      tabataSettings.setWorkTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer(
                      durationToString2(tabataSettings.workTime.duration!),
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
                    final selectedTime = await TimePicker.showTimePicker(
                      context,
                      initialDuration: tabataSettings.restTime.duration!,
                    );
                    if (selectedTime != null) {
                      tabataSettings.setRestTime(selectedTime);
                    }
                  },
                  child: Observer(
                    builder: (ctx) => ValueContainer(
                      durationToString2(tabataSettings.restTime.duration!),
                      width: 60,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Observer(builder: (ctx) {
              return Column(
                children: [
                  if (tabataSettings.showSets) buildSetsSettings(context),
                  MainButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (tabataSettings.showSets)
                          const Icon(
                            Icons.delete_forever,
                            color: AppColors.red,
                          ),
                        if (!tabataSettings.showSets)
                          const Icon(
                            Icons.add_circle_outline,
                            color: AppColors.accentBlue,
                          ),
                        const SizedBox(width: 4),
                        Text(
                          tabataSettings.showSets ? 'Delete sets' : 'Add sets (optional)',
                          style: AppFonts.actionButton
                              .copyWith(color: tabataSettings.showSets ? AppColors.red : AppColors.accentBlue),
                        ),
                      ],
                    ),
                    onPressed: () {
                      tabataSettings.toggleShowSets();
                    },
                    color: AppColors.transparent,
                  ),
                ],
              );
            }),
            const Spacer(),
            Observer(
              builder: (ctx) => Text(
                'Total time: ${durationToString2(tabataSettings.totalTime)}',
                style: AppFonts.body,
              ),
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
                  //TODO: replace with new router
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
