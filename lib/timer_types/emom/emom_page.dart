import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/bottom_sheets/rounds_picker.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/quantity_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import 'emom_state.dart';

class EmomPage extends StatefulWidget {
  const EmomPage({Key? key}) : super(key: key);

  @override
  State<EmomPage> createState() => _EmomPageState();
}

class _EmomPageState extends State<EmomPage> {
  late final EmomState emomState;

  @override
  void initState() {
    final settingsJson = GetIt.I<AppProperties>().getEmomSettings();
    emomState = settingsJson != null ? EmomState.fromJson(settingsJson) : EmomState();
    super.initState();
  }

  @override
  void dispose() {
    final json = emomState.toJson();
    GetIt.I<AppProperties>().setEmomSettings(json);
    super.dispose();
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
            workout: emomState.workout,
            timerType: TimerType.emom,
          ),
        ),
      ),
      slivers: [
        Observer(
          builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return _buildEmom(index);
                },
                childCount: emomState.emoms.length,
              ),
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 26),
          sliver: SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: emomState.addEmom,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add_circle_outline, size: 20
                      // color: AppColors.accentBlue,
                      ),
                  SizedBox(width: 4),
                  Text('Add another EMOM')
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildEmom(int emomIndex) {
    final emom = emomState.emoms[emomIndex];
    bool isLast = emomIndex == emomState.emoms.length - 1;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EMOM ${emomIndex + 1}',
                style: context.textTheme.subtitle1,
              ),
              const SizedBox(height: 8),
              Row(
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
                        emomState.setWorkTime(emomIndex, selectedTime);
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  QuantityWidget(
                    title: 'Rounds:',
                    quantity: emom.roundsCount,
                    onTap: () async {
                      final rounds = await RoundsPicker.showRoundsPicker(
                        context,
                        title: 'Rounds',
                        initialValue: emom.roundsCount,
                        range: tabataRounds,
                      );
                      if (rounds != null) {
                        emomState.setRounds(emomIndex, rounds);
                      }
                    },
                  ),
                ],
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      IntervalWidget(
                        title: 'Rest after EMOM ${emomIndex + 1}:',
                        duration: emom.restAfterSet,
                        onTap: () async {
                          final selectedTime = await TimePicker.showTimePicker(
                            context,
                            initialDuration: emom.restAfterSet,
                          );
                          if (selectedTime != null) {
                            emomState.setRestAfterSet(emomIndex, selectedTime);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              if (emomState.emoms.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      TextButtonTheme(
                        data: context.buttonThemes.deleteButtonTheme,
                        child: TextButton(
                          onPressed: () {
                            emomState.deleteEmom(emomIndex);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Remove EMOM ${emomIndex + 1}',
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const Divider(thickness: 5, height: 5),
      ],
    );
  }
}
