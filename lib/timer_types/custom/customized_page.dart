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

import 'customized_state.dart';

class CustomizedPage extends StatefulWidget {
  const CustomizedPage({Key? key}) : super(key: key);

  @override
  State<CustomizedPage> createState() => _CustomizedPageState();
}

class _CustomizedPageState extends State<CustomizedPage> {
  late final CustomizedState customSettings;

  @override
  void initState() {
    final json = GetIt.I<AppProperties>().getCustomSettings();
    customSettings = json != null ? CustomizedState.fromJson(json) : CustomizedState();
    super.initState();
  }

  @override
  void dispose() {
    final json = customSettings.toJson();
    GetIt.I<AppProperties>().setCustomSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'Custom',
          style: AppFonts.header2,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Set your Custom Timer',
              style: AppFonts.header2,
            ),
            TextButton(
              child: Text(
                'Show description',
                style: AppFonts.buttonTitle.copyWith(color: AppColors.accentBlue),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return WorkoutDesc(customSettings.workout);
                }));
              },
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Observer(builder: (ctx) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...customSettings.sets.asMap().keys.map(
                            (index) => buildRoundSettings(context, index),
                          ),
                      TextButton(
                        onPressed: () {
                          customSettings.addRound();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.add_box_outlined,
                              size: 28,
                              color: AppColors.accentBlue,
                            ),
                            SizedBox(width: 4),
                            Text('Add new block')
                          ],
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

  Widget buildRoundSettings(BuildContext context, int setIndex) {
    final intervals = customSettings.sets[setIndex];
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                        title: 'Rounds',
                        initialValue: customSettings.roundsCounts[setIndex],
                        range: tabataRounds,
                      );
                      if (selectedRounds != null) {
                        customSettings.setRounds(setIndex, selectedRounds);
                      }
                    },
                    child: Observer(
                      builder: (ctx) => ValueContainer('${customSettings.roundsCounts[setIndex]}'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              ...intervals.asMap().keys.map(
                (intervalIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Interval ${intervalIndex + 1}:',
                          style: AppFonts.body,
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              initialDuration: intervals[intervalIndex],
                            );
                            if (selectedTime != null) {
                              customSettings.setInterval(setIndex, intervalIndex, selectedTime);
                            }
                          },
                          child: Observer(
                            builder: (ctx) => ValueContainer(
                              durationToString2(intervals[intervalIndex]),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            customSettings.deleteInterval(setIndex, intervalIndex);
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
              TextButton(
                onPressed: () {
                  customSettings.addInterval(setIndex);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.add_circle_outline,
                      size: 28,
                      color: AppColors.accentBlue,
                    ),
                    SizedBox(width: 4),
                    Text('Add interval')
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            customSettings.deleteRound(setIndex);
          },
          icon: const Icon(
            Icons.close_sharp,
            color: AppColors.red,
          ),
        ),
      ],
    );
  }
}
