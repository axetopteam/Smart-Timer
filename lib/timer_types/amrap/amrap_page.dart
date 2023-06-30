import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/utils/interable_extension.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';

import 'amrap_state.dart';

class AmrapPage extends StatefulWidget {
  const AmrapPage({Key? key}) : super(key: key);

  @override
  State<AmrapPage> createState() => _AmrapPageState();
}

class _AmrapPageState extends State<AmrapPage> {
  late final AmrapState amrap;

  @override
  void initState() {
    final json = GetIt.I<AppProperties>().getAmrapSettings();
    amrap = json != null ? AmrapState.fromJson(json) : AmrapState();

    super.initState();
  }

  @override
  void dispose() {
    final json = amrap.toJson();
    GetIt.I<AppProperties>().setAmrapSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimerSetupScaffold(
      color: context.color.amrapColor,
      appBarTitle: 'AMRAP',
      subtitle: 'Repeat as many rounds as\npossible for selected time',
      onStartPressed: () => context.router.push(
        TimerRoute(
          state: TimerState(
            workout: amrap.workout,
            timerType: TimerType.amrap,
          ),
        ),
      ),
      slivers: [
        Observer(
          builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return _buildRound(index);
                },
                childCount: amrap.rounds.length,
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
              onPressed: amrap.addRound,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add_circle_outline, size: 20
                      // color: AppColors.accentBlue,
                      ),
                  SizedBox(width: 4),
                  Text('Add another AMRAP')
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildRound(int roundIndex) {
    return Observer(
      builder: (context) {
        final intervals = amrap.rounds[roundIndex];
        bool isLast = roundIndex == amrap.roundsCound - 1;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AMRAP ${roundIndex + 1}',
                    style: context.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...intervals.asMap().keys.map(
                        (intervalIndex) {
                          if (isLast && intervalIndex == 1) return Container();
                          return IntervalWidget(
                            title: intervalIndex == 0 ? 'Work:' : 'Rest',
                            duration: intervals[intervalIndex],
                            onTap: () async {
                              final selectedTime = await TimePicker.showTimePicker(
                                context,
                                initialDuration: intervals[intervalIndex],
                              );
                              if (selectedTime != null) {
                                amrap.setInterval(roundIndex, intervalIndex, selectedTime);
                              }
                            },
                          );
                        },
                      ).addSeparator(!isLast ? const SizedBox(width: 10) : const SizedBox()),
                    ],
                  ),
                  if (amrap.rounds.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          TextButtonTheme(
                            data: context.buttonThemes.deleteButtonTheme,
                            child: TextButton(
                              onPressed: () {
                                amrap.deleteRound(roundIndex);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Remove AMRAP ${roundIndex + 1}',
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
