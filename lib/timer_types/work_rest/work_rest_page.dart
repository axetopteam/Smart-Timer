import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/widgets/ratio_widget.dart';
import 'package:smart_timer/widgets/rounds_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import 'work_rest_state.dart';

class WorkRestPage extends StatefulWidget {
  const WorkRestPage({Key? key}) : super(key: key);

  @override
  State<WorkRestPage> createState() => _WorkRestPageState();
}

class _WorkRestPageState extends State<WorkRestPage> {
  late final WorkRestState workRest;

  @override
  void initState() {
    final settingsJson = GetIt.I<AppProperties>().getWorkRestSettings();
    workRest = settingsJson != null ? WorkRestState.fromJson(settingsJson) : WorkRestState();
    super.initState();
  }

  @override
  void dispose() {
    final json = workRest.toJson();
    GetIt.I<AppProperties>().setWorkRestSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.workRestColor,
      appBarTitle: LocaleKeys.work_rest_title.tr(),
      subtitle: LocaleKeys.work_rest_description.tr(),
      onStartPressed: () => context.router.push(
        TimerRoute(
          state: TimerState(
            workout: workRest.workout,
            timerType: TimerType.workRest,
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
                    RoundsWidget(
                      title: '${LocaleKeys.rounds.tr()}:',
                      initialValue: workRest.roundsCount,
                      onValueChanged: (value) {
                        workRest.setRounds(value);
                      },
                    ),
                    const SizedBox(width: 10),
                    RatioWidget(
                      title: '${LocaleKeys.rest_ratio.tr()}:',
                      initialValue: workRest.ratio,
                      onValueChanged: (value) => workRest.setRatio(value),
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
