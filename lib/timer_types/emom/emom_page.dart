import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/bottom_sheets/rounds_picker.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/quantity_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';
import 'package:smart_timer/widgets/value_container.dart';

import 'emom_state.dart';

class EmomPage extends StatefulWidget {
  const EmomPage({Key? key}) : super(key: key);

  @override
  State<EmomPage> createState() => _EmomPageState();
}

class _EmomPageState extends State<EmomPage> {
  late final EmomState emom;

  @override
  void initState() {
    final settingsJson = GetIt.I<AppProperties>().getEmomSettings();
    emom = settingsJson != null ? EmomState.fromJson(settingsJson) : EmomState();
    super.initState();
  }

  @override
  void dispose() {
    final json = emom.toJson();
    GetIt.I<AppProperties>().setEmomSettings(json);
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
                  initialDuration: emom.restBetweenSets,
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
    return TimerSetupScaffold(
      color: context.color.emomColor,
      appBarTitle: 'EMOM',
      subtitle: 'Repeat several rounds every minute on minute',
      onStartPressed: () => context.router.push(
        TimerRoute(
          state: TimerState(
            workout: emom.workout,
            timerType: TimerType.emom,
          ),
        ),
      ),
      slivers: [
        Observer(
          builder: (context) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntervalWidget(
                      title: 'Work time:',
                      duration: emom.workTime,
                      onTap: () async {
                        final selectedTime = await TimePicker.showTimePicker(
                          context,
                          initialDuration: emom.workTime,
                        );
                        if (selectedTime != null) {
                          emom.setWorkTime(selectedTime);
                        }
                      },
                    ),
                    QuantityWidget(
                      title: 'Rounds:',
                      quantity: emom.roundsCount,
                      onTap: () async {
                        final rounds = await RoundsPicker.showRoundsPicker(
                          context,
                          initialValue: emom.roundsCount,
                          range: tabataRounds,
                        );
                        if (rounds != null) {
                          emom.setRounds(rounds);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
