import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/UI/bottom_sheets/rounds_picker.dart';
import 'package:smart_timer/UI/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/utils/string_utils.dart';

import '../../pages/workout_desc.dart';
import '../../widgets/value_container.dart';
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
    customSettings = CustomizedState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Custom',
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Set your Custom Timer',
            ),
            TextButton(
              child: Text(
                'Show description',
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40),
            //   child: MainButton(
            //     child: const Text(
            //       'START TIMER',
            //       style: AppFonts.buttonTitle,
            //     ),
            //     borderRadius: 20,
            //     onPressed: () {
            //       //TODO: replace with new router
            //     },
            //     color: AppColors.accentBlue,
            //   ),
            // )
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
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              title: LocaleKeys.rest_time.tr(),
                              initialDuration: intervals[intervalIndex],
                            );
                            if (selectedTime != null) {
                              customSettings.setInterval(setIndex, intervalIndex, selectedTime);
                            }
                          },
                          child: Observer(
                            builder: (ctx) => ValueContainer(
                              intervals[intervalIndex].readableString,
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
          ),
        ),
      ],
    );
  }
}
