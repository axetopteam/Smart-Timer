import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/utils/constans.dart';
import 'package:smart_timer/utils/interable_extension.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import 'afap_state.dart';

class AfapPage extends StatefulWidget {
  const AfapPage({Key? key}) : super(key: key);

  @override
  State<AfapPage> createState() => _AfapPageState();
}

class _AfapPageState extends State<AfapPage> {
  late final AfapState afap;

  @override
  void initState() {
    super.initState();
    final json = GetIt.I<AppProperties>().getAfapSettings();
    afap = json != null ? AfapState.fromJson(json) : AfapState();
  }

  @override
  void dispose() {
    final json = afap.toJson();
    GetIt.I<AppProperties>().setAfapSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.afapColor,
      appBarTitle: 'For Time',
      subtitle: 'Repeat rounds as fast as possible for selected time',
      onStartPressed: () => context.pushRoute(
        TimerRoute(
          state: TimerState(
            workout: afap.workout,
            timerType: TimerType.afap,
          ),
        ),
      ),
      slivers: [
        Observer(
          builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return buildRound(index);
                },
                childCount: afap.rounds.length,
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
              onPressed: afap.addRound,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add_circle_outline, size: 20
                      // color: AppColors.accentBlue,
                      ),
                  SizedBox(width: 4),
                  Text('Add another round')
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget buildRound(int roundIndex) {
    return Observer(
      builder: (context) {
        final intervals = afap.rounds[roundIndex];
        bool isLast = roundIndex == afap.roundsCound - 1;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AFAP ${roundIndex + 1}',
                    style: context.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...intervals.asMap().keys.map(
                        (intervalIndex) {
                          if (isLast && intervalIndex == 1) return Container();
                          return IntervalWidget(
                            title: intervalIndex == 0 ? 'Time cap:' : 'Rest time',
                            duration: intervals[intervalIndex],
                            onTap: () async {
                              final selectedTime = await TimePicker.showTimePicker(
                                context,
                                initialDuration: intervals[intervalIndex],
                                showNoCap: intervalIndex == 0,
                              );
                              if (selectedTime != null) {
                                afap.setInterval(
                                  roundIndex,
                                  intervalIndex,
                                  selectedTime == noTimeCapDuration ? null : selectedTime,
                                );
                              }
                            },
                          );
                        },
                      ).addSeparator(!isLast ? const SizedBox(width: 10) : const SizedBox()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        TextButtonTheme(
                          data: context.buttonThemes.deleteButtonTheme,
                          child: TextButton(
                            onPressed: () {
                              afap.deleteRound(roundIndex);
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Remove AFAP ${roundIndex + 1}',
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
