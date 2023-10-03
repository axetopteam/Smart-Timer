import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/analytics/analytics_manager.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/UI/timer/timer_state.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';

import '../../widgets/ratio_widget.dart';
import '../../widgets/rounds_widget.dart';
import '../../widgets/timer_setup_scaffold.dart';
import 'work_rest_state.dart';
export 'work_rest_state.dart' show WorkRestSettings;

@RoutePage<void>()
class WorkRestPage extends StatefulWidget {
  const WorkRestPage({this.workRestSettings, Key? key}) : super(key: key);
  final WorkRestSettings? workRestSettings;

  @override
  State<WorkRestPage> createState() => _WorkRestPageState();
}

class _WorkRestPageState extends State<WorkRestPage> {
  late final WorkRestState workRest;

  @override
  void initState() {
    workRest = WorkRestState(sets: widget.workRestSettings?.workRests);
    AnalyticsManager.eventSetupPageOpened.setProperty('timer_type', TimerType.workRest.name).commit();
    super.initState();
  }

  @override
  void dispose() {
    AnalyticsManager.eventSetupPageClosed.setProperty('timer_type', TimerType.workRest.name).commit();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.workRestColor,
      appBarTitle: LocaleKeys.work_rest_title.tr(),
      subtitle: LocaleKeys.work_rest_description.tr(),
      addToFavorites: workRest.saveToFavorites,
      onStartPressed: () {
        context.router.push(
          TimerRoute(
            state: TimerState(
              workout: workRest.workout,
              timerType: TimerType.workRest,
            ),
          ),
        );
      },
      slivers: [
        Observer(
          builder: (context) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundsWidget(
                      title: LocaleKeys.rounds.tr(),
                      initialValue: workRest.sets[workRest.setIndex].roundsCount,
                      onValueChanged: (value) {
                        workRest.setRounds(workRest.setIndex, value);
                      },
                    ),
                    const SizedBox(width: 10),
                    RatioWidget(
                      title: '${LocaleKeys.rest_ratio.tr()}:',
                      initialValue: workRest.sets[workRest.setIndex].ratio,
                      onValueChanged: (value) {
                        workRest.setRatio(workRest.setIndex, value);
                        AnalyticsManager.eventWorkRestSetRatio.setProperty('ratio', value).commit();
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
