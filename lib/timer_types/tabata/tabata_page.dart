import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/rounds_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import '../../widgets/new_item_transition.dart';
import 'tabata_state.dart';

@RoutePage()
class TabataPage extends StatefulWidget {
  const TabataPage({Key? key}) : super(key: key);

  @override
  State<TabataPage> createState() => _TabataPageState();
}

class _TabataPageState extends State<TabataPage> {
  late final TabataState tabataState;
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  SliverAnimatedListState get _animatedList => _listKey.currentState!;
  final _scroolController = ScrollController();

  @override
  void initState() {
    final settingsJson = AppProperties().getTabataSettings();
    tabataState = settingsJson != null ? TabataState.fromJson(settingsJson) : TabataState();
    AnalyticsManager.eventSetupPageOpened.setProperty('timer_type', TimerType.tabata.name).commit();

    super.initState();
  }

  @override
  dispose() {
    final json = tabataState.toJson();
    AppProperties().setTabataSettings(json);
    _scroolController.dispose();
    AnalyticsManager.eventSetupPageClosed.setProperty('timer_type', TimerType.tabata.name).commit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.tabataColor,
      appBarTitle: LocaleKeys.tabata_title.tr(),
      subtitle: LocaleKeys.tabata_description.tr(),
      scrollController: _scroolController,
      workout: () => tabataState.workout,
      onStartPressed: () {
        context.router.push(
          TimerRoute(
            state: TimerState(
              workout: tabataState.workout,
              timerType: TimerType.tabata,
            ),
          ),
        );
      },
      slivers: [
        SliverAnimatedList(
          key: _listKey,
          initialItemCount: tabataState.tabatsCount,
          itemBuilder: _itemBuilder,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(30, 26, 30, 0),
          sliver: SliverToBoxAdapter(
              child: ElevatedButton(
            onPressed: _addNewTabata,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_circle_outline, size: 20),
                const SizedBox(width: 4),
                Text(LocaleKeys.tabata_add_button_title.tr())
              ],
            ),
          )),
        ),
      ],
    );
  }

  void _addNewTabata() {
    tabataState.addTabata();
    _animatedList.insertItem(tabataState.tabatsCount - 1, duration: const Duration(milliseconds: 200));
    Future.delayed(
        const Duration(milliseconds: 200),
        () => _scroolController.animateTo(
              _scroolController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ));

    AnalyticsManager.eventSetupPageNewSetAdded
        .setProperty('timer_type', TimerType.tabata.name)
        .setProperty('sets_count', tabataState.tabatsCount)
        .commit();
  }

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return Observer(builder: (ctx) {
      final tabata = tabataState.tabats[index];
      final isLast = index == tabataState.tabatsCount - 1;
      return NewItemTransition(
        animation: animation,
        child: _buildTabata(
          tabata: tabata,
          isLast: isLast,
          index: index,
        ),
      );
    });
  }

  Widget _buildTabata({
    required Tabata tabata,
    required bool isLast,
    required index,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocaleKeys.tabata_title.tr()} ${index + 1}',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  RoundsWidget(
                    title: '${LocaleKeys.rounds.tr()}:',
                    initialValue: tabata.roundsCount,
                    onValueChanged: (rounds) => tabataState.setRounds(index, rounds),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        tabataState.setWorkTime(index, selectedTime);
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
                        tabataState.setRestTime(index, selectedTime);
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
                        title: LocaleKeys.rest_after_time.tr(args: ['${LocaleKeys.tabata_title.tr()} ${index + 1}']),
                        duration: tabata.restAfterSet,
                        onTap: () async {
                          final selectedTime = await TimePicker.showTimePicker(
                            context,
                            initialDuration: tabata.restAfterSet,
                          );
                          if (selectedTime != null) {
                            tabataState.setRestAfterSet(index, selectedTime);
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
                            _animatedList.removeItem(
                              index,
                              (context, animation) => NewItemTransition(
                                animation: animation,
                                child: _buildTabata(
                                  tabata: tabata,
                                  isLast: isLast,
                                  index: index,
                                ),
                              ),
                            );
                            tabataState.deleteTabata(index);
                            AnalyticsManager.eventSetupPageSetRemoved
                                .setProperty('timer_type', TimerType.tabata.name)
                                .setProperty('sets_count', tabataState.tabatsCount)
                                .commit();
                          },
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.tabata_delete_button_title.tr(args: ['${index + 1}']),
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
