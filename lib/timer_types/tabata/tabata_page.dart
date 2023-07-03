import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/bottom_sheets/rounds_picker.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/quantity_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import 'tabata_state.dart';

class TabataPage extends StatefulWidget {
  const TabataPage({Key? key}) : super(key: key);

  @override
  State<TabataPage> createState() => _TabataPageState();
}

class _TabataPageState extends State<TabataPage> {
  late final TabataState tabataState;

  @override
  void initState() {
    final settingsJson = GetIt.I<AppProperties>().getTabataSettings();
    tabataState = settingsJson != null ? TabataState.fromJson(settingsJson) : TabataState();

    super.initState();
  }

  @override
  dispose() {
    final json = tabataState.toJson();
    GetIt.I<AppProperties>().setTabataSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.tabataColor,
      appBarTitle: LocaleKeys.tabata_title.tr(),
      subtitle: LocaleKeys.tabata_description.tr(),
      workout: () => tabataState.workout,
      onStartPressed: () => context.router.push(
        TimerRoute(
          state: TimerState(
            workout: tabataState.workout,
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
                  return _buildTabata(index);
                },
                childCount: tabataState.tabatsCount,
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
              onPressed: tabataState.addTabata,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_circle_outline, size: 20),
                  const SizedBox(width: 4),
                  Text(LocaleKeys.tabata_add_button_title.tr())
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildTabata(int tabataIndex) {
    return Observer(builder: (context) {
      final tabata = tabataState.tabats[tabataIndex];
      bool isLast = tabataIndex == tabataState.tabatsCount - 1;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LocaleKeys.tabata_title.tr()} ${tabataIndex + 1}',
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    QuantityWidget(
                      flex: 1,
                      title: '${LocaleKeys.rounds.tr()}:',
                      quantity: tabata.roundsCount,
                      onTap: () async {
                        final rounds = await RoundsPicker.showRoundsPicker(
                          context,
                          title: LocaleKeys.rounds.tr(),
                          initialValue: tabata.roundsCount,
                          range: tabataRounds,
                        );
                        if (rounds != null) {
                          tabataState.setRounds(tabataIndex, rounds);
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    IntervalWidget(
                      flex: 2,
                      title: LocaleKeys.work_time.tr(),
                      duration: tabata.workTime,
                      onTap: () async {
                        final selectedTime = await TimePicker.showTimePicker(
                          context,
                          initialDuration: tabata.workTime,
                        );
                        if (selectedTime != null) {
                          tabataState.setWorkTime(tabataIndex, selectedTime);
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    IntervalWidget(
                      flex: 2,
                      title: LocaleKeys.rest_time.tr(),
                      duration: tabata.restTime,
                      onTap: () async {
                        final selectedTime = await TimePicker.showTimePicker(
                          context,
                          initialDuration: tabata.restTime,
                        );
                        if (selectedTime != null) {
                          tabataState.setRestTime(tabataIndex, selectedTime);
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
                          title: LocaleKeys.rest_after_time
                              .tr(args: ['${LocaleKeys.tabata_title.tr()} ${tabataIndex + 1}:']),
                          duration: tabata.restAfterSet,
                          onTap: () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              initialDuration: tabata.restAfterSet,
                            );
                            if (selectedTime != null) {
                              tabataState.setRestAfterSet(tabataIndex, selectedTime);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                if (tabataState.tabatsCount > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        TextButtonTheme(
                          data: context.buttonThemes.deleteButtonTheme,
                          child: TextButton(
                            onPressed: () {
                              tabataState.deleteTabata(tabataIndex);
                            },
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.tabata_delete_button_title.tr(args: ['${tabataIndex + 1}']),
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
    });
  }
}
