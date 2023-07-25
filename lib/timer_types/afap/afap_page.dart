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

import 'afap_state.dart';

@RoutePage()
class AfapPage extends StatefulWidget {
  const AfapPage({Key? key}) : super(key: key);

  @override
  State<AfapPage> createState() => _AfapPageState();
}

class _AfapPageState extends State<AfapPage> {
  late final AfapState afapState;

  @override
  void initState() {
    super.initState();
    final json = AppProperties().getAfapSettings();
    afapState = json != null ? AfapState.fromJson(json) : AfapState();
    AnalyticsManager.eventAfapOpened.commit();
  }

  @override
  void dispose() {
    final json = afapState.toJson();
    AppProperties().setAfapSettings(json);
    AnalyticsManager.eventAfapClosed.commit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.afapColor,
      appBarTitle: LocaleKeys.afap_title.tr(),
      subtitle: LocaleKeys.afap_description.tr(),
      onStartPressed: () {
        AnalyticsManager.eventAfapTimerStarted.setProperty('setsCount', afapState.afapsCount).commit();
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
        Observer(
          builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return _buildAfap(index);
                },
                childCount: afapState.afapsCount,
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
              onPressed: () {
                afapState.addAfap();
                AnalyticsManager.eventAfapNewAdded.commit();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_circle_outline, size: 20),
                  const SizedBox(width: 4),
                  Text(LocaleKeys.afap_add_button_title.tr())
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildAfap(int afapIndex) {
    return Observer(
      builder: (context) {
        final afap = afapState.afaps[afapIndex];
        bool isLast = afapIndex == afapState.afapsCount - 1;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${LocaleKeys.afap_name.tr()} ${afapIndex + 1}',
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
                                  initialDuration: afap.timeCap,
                                );
                                if (selectedTime != null) {
                                  afapState.setTimeCap(afapIndex, selectedTime);
                                }
                              }
                            : null,
                        onNoTimeCapChanged: (newValue) {
                          if (newValue != null) {
                            afapState.setNoTimeCap(
                              afapIndex,
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
                              initialDuration: afap.restTime,
                            );
                            if (selectedTime != null) {
                              afapState.setRestTime(afapIndex, selectedTime);
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
                                afapState.deleteAfap(afapIndex);
                                AnalyticsManager.eventAfapRemoved.commit();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    LocaleKeys.afap_delete_button_title.tr(args: ['${afapIndex + 1}']),
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
      },
    );
  }
}
