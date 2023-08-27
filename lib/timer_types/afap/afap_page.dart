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
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import '../../widgets/new_item_transition.dart';
import 'afap_state.dart';

@RoutePage()
class AfapPage extends StatefulWidget {
  const AfapPage({Key? key}) : super(key: key);

  @override
  State<AfapPage> createState() => _AfapPageState();
}

class _AfapPageState extends State<AfapPage> {
  late final AfapState afapState;
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  SliverAnimatedListState get _animatedList => _listKey.currentState!;
  final _scroolController = ScrollController();

  @override
  void initState() {
    super.initState();
    final json = AppProperties().getAfapSettings();
    afapState = json != null ? AfapState.fromJson(json) : AfapState();
    AnalyticsManager.eventSetupPageOpened.setProperty('timer_type', TimerType.afap.name).commit();
  }

  @override
  void dispose() {
    final json = afapState.toJson();
    AppProperties().setAfapSettings(json);
    _scroolController.dispose();
    AnalyticsManager.eventSetupPageClosed.setProperty('timer_type', TimerType.afap.name).commit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.afapColor,
      appBarTitle: LocaleKeys.afap_title.tr(),
      subtitle: LocaleKeys.afap_description.tr(),
      scrollController: _scroolController,
      onStartPressed: () {
        context.pushRoute(
          TimerRoute(
            state: TimerState(
              workout: afapState.workout,
              timerType: TimerType.afap,
            ),
          ),
        );
      },
      slivers: [
        SliverAnimatedList(
          key: _listKey,
          initialItemCount: afapState.afapsCount,
          itemBuilder: _itemBuilder,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(30, 26, 30, 0),
          sliver: SliverToBoxAdapter(
              child: ElevatedButton(
            onPressed: _addNewAfap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add_circle_outline, size: 20),
                const SizedBox(width: 4),
                Text(LocaleKeys.afap_add_button_title.tr())
              ],
            ),
          )),
        ),
      ],
    );
  }

  void _addNewAfap() {
    afapState.addAfap();
    _animatedList.insertItem(afapState.afapsCount - 1, duration: const Duration(milliseconds: 200));
    Future.delayed(
        const Duration(milliseconds: 200),
        () => _scroolController.animateTo(
              _scroolController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ));

    AnalyticsManager.eventSetupPageNewSetAdded
        .setProperty('timer_type', TimerType.afap.name)
        .setProperty('sets_count', afapState.afapsCount)
        .commit();
  }

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return Observer(builder: (ctx) {
      final afap = afapState.afaps[index];
      final isLast = index == afapState.afapsCount - 1;
      return NewItemTransition(
        animation: animation,
        child: _buildAfap(
          afap: afap,
          isLast: isLast,
          index: index,
        ),
      );
    });
  }

  Widget _buildAfap({
    required Afap afap,
    required bool isLast,
    required index,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocaleKeys.afap_name.tr()} ${index + 1}',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntervalWidget(
                    title: '${LocaleKeys.time_cap.tr()}:',
                    duration: afap.noTimeCap ? null : afap.timeCap,
                    canBeUnlimited: true,
                    onTap: !afap.noTimeCap
                        ? () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              title: LocaleKeys.time_cap.tr(),
                              initialDuration: afap.timeCap,
                            );
                            if (selectedTime != null) {
                              afapState.setTimeCap(index, selectedTime);
                            }
                          }
                        : null,
                    onNoTimeCapChanged: (newValue) {
                      if (newValue != null) {
                        afapState.setNoTimeCap(
                          index,
                          newValue,
                        );
                      }
                    },
                  ),
                  if (!isLast) const SizedBox(width: 10),
                  if (!isLast)
                    IntervalWidget(
                      title: LocaleKeys.rest_time.tr(),
                      duration: afap.restTime,
                      canBeUnlimited: false,
                      onTap: () async {
                        final selectedTime = await TimePicker.showTimePicker(
                          context,
                          title: LocaleKeys.rest.tr(),
                          initialDuration: afap.restTime,
                        );
                        if (selectedTime != null) {
                          afapState.setRestTime(index, selectedTime);
                        }
                      },
                    ),
                ],
              ),
              if (afapState.afapsCount > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
                                child: _buildAfap(
                                  afap: afap,
                                  isLast: isLast,
                                  index: index,
                                ),
                              ),
                            );
                            afapState.deleteAfap(index);
                            AnalyticsManager.eventSetupPageSetRemoved
                                .setProperty('timer_type', TimerType.afap.name)
                                .setProperty('sets_count', afapState.afapsCount)
                                .commit();
                          },
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.afap_delete_button_title.tr(args: ['${index + 1}']),
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
