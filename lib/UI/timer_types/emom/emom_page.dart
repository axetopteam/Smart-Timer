import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/UI/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';

import '../../widgets/interval_widget.dart';
import '../../widgets/new_item_transition.dart';
import '../../widgets/rounds_widget.dart';
import '../../widgets/timer_setup_scaffold.dart';
import 'emom_state.dart';

export 'emom_state.dart' show EmomSettings;

@RoutePage<void>()
class EmomPage extends StatefulWidget {
  const EmomPage({this.emomSettings, Key? key}) : super(key: key);

  final EmomSettings? emomSettings;

  @override
  State<EmomPage> createState() => _EmomPageState();
}

class _EmomPageState extends State<EmomPage> {
  late final EmomState emomState;
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  SliverAnimatedListState get _animatedList => _listKey.currentState!;
  final _scroolController = ScrollController();

  @override
  void initState() {
    emomState = EmomState(emoms: widget.emomSettings?.emoms);
    AnalyticsManager.eventSetupPageOpened.setProperty('timer_type', TimerType.emom.name).commit();
    super.initState();
  }

  @override
  void dispose() {
    _scroolController.dispose();
    AnalyticsManager.eventSetupPageClosed.setProperty('timer_type', TimerType.emom.name).commit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return TimerSetupScaffold(
        color: context.color.emomColor,
        appBarTitle: LocaleKeys.emom_title.tr(),
        subtitle: LocaleKeys.emom_description.tr(),
        scrollController: _scroolController,
        // workout: emomState.workout,
        addToFavorites: emomState.saveToFavorites,
        onStartPressed: () {
          context.router.push(TimerRoute(timerSettings: emomState));
        },
        slivers: [
          SliverAnimatedList(
            key: _listKey,
            initialItemCount: emomState.emomsCount,
            itemBuilder: _itemBuilder,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(30, 26, 30, 0),
            sliver: SliverToBoxAdapter(
                child: ElevatedButton(
              onPressed: _addNewEmom,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_circle_outline, size: 20),
                  const SizedBox(width: 4),
                  Text(LocaleKeys.emom_add_button_title.tr())
                ],
              ),
            )),
          ),
        ],
      );
    });
  }

  void _addNewEmom() {
    emomState.addEmom();
    _animatedList.insertItem(emomState.emomsCount - 1, duration: const Duration(milliseconds: 200));
    Future.delayed(
      const Duration(milliseconds: 250),
      () => _scroolController.animateTo(
        _scroolController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );

    AnalyticsManager.eventSetupPageNewSetAdded
        .setProperty('timer_type', TimerType.emom.name)
        .setProperty('sets_count', emomState.emomsCount)
        .commit();
  }

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return Observer(builder: (ctx) {
      final emom = emomState.emoms[index];
      final isLast = index == emomState.emomsCount - 1;
      return NewItemTransition(
        animation: animation,
        child: _buildEmom(
          emom: emom,
          isLast: isLast,
          index: index,
        ),
      );
    });
  }

  Widget _buildEmom({
    required Emom emom,
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
                '${LocaleKeys.emom_title.tr()} ${index + 1}',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundsWidget(
                        title: LocaleKeys.rounds.tr(),
                        initialValue: emom.roundsCount,
                        onValueChanged: (value) => emomState.setRounds(index, value),
                        unlimited: emom.deathBy,
                      ),
                      const SizedBox(width: 10),
                      IntervalWidget(
                        title: LocaleKeys.work_time.tr(),
                        duration: emom.workTime,
                        onTap: () async {
                          final selectedTime = await TimePicker.showTimePicker(
                            context,
                            title: LocaleKeys.work.tr(),
                            initialDuration: emom.workTime,
                          );
                          if (selectedTime != null) {
                            emomState.setWorkTime(index, selectedTime);
                          }
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Transform.translate(
                      offset: const Offset(-10, 0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            CupertinoCheckbox(
                              value: emom.deathBy,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  emomState.setDeathBy(
                                    index,
                                    newValue,
                                  );
                                }
                              },
                            ),
                            Expanded(child: Text('Death By')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      IntervalWidget(
                        title: LocaleKeys.rest_after_time.tr(args: ['${LocaleKeys.emom_title.tr()} ${index + 1}']),
                        duration: emom.restAfterSet,
                        onTap: () async {
                          final selectedTime = await TimePicker.showTimePicker(
                            context,
                            title: LocaleKeys.rest_between_sets.tr(),
                            initialDuration: emom.restAfterSet,
                          );
                          if (selectedTime != null) {
                            emomState.setRestAfterSet(index, selectedTime);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              if (emomState.emomsCount > 1)
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
                                child: _buildEmom(
                                  emom: emom,
                                  isLast: isLast,
                                  index: index,
                                ),
                              ),
                            );
                            emomState.deleteEmom(index);
                            AnalyticsManager.eventSetupPageSetRemoved
                                .setProperty('timer_type', TimerType.emom.name)
                                .setProperty('sets_count', emomState.emomsCount)
                                .commit();
                          },
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.emom_delete_button_title.tr(args: ['${index + 1}']),
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
