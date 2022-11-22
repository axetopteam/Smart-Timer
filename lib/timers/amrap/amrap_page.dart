import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/bottom_sheets/time_picker.dart';
import 'package:smart_timer/routes/main_auto_router.gr.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/start_button.dart';

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
    final safeOffset = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: Observer(
        builder: (ctx) => Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: false,
                  title: const Text('AMRAP'),
                  pinned: true,
                  backgroundColor: context.color.amrapColor,
                  expandedHeight: 140.0,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.only(left: 94, top: 120),
                      child: Text(
                        'Repeat as many rounds as\npossible for selected time',
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                      return buildRound(index);
                    },
                    childCount: amrap.rounds.length,
                  ),
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
                SliverToBoxAdapter(child: SizedBox(height: safeOffset.bottom + 100))
              ],
            ),
            Positioned(
              right: 0,
              bottom: safeOffset.bottom,
              child: StartButton(
                  backgroundColor: context.color.amrapColor,
                  //TODO: replace with new router

                  onPressed: () => GetIt.I<AppRouter>().push(TimerRoute(workout: amrap.workout))
                  //  getIt<RouterInterface>().showTimer(amrap.workout),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRound(int roundIndex) {
    final intervals = amrap.rounds[roundIndex];
    bool isLast = roundIndex == amrap.roundsCound - 1;
    bool isFirst = roundIndex == 0;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, isFirst ? 34 : 20),
          // decoration: BoxDecoration(
          //   border: Border(
          //     bottom: BorderSide(width: 5, color: AppColors.greyBlue),
          //   ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AMRAP ${roundIndex + 1}',
                style: context.textTheme.subtitle1,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...intervals.asMap().keys.map((intervalIndex) {
                    if (isLast && intervalIndex == 1) return Container();
                    return IntervalWidget(
                      title: intervalIndex == 0 ? 'Work:' : 'Rest',
                      duration: intervals[intervalIndex],
                      onTap: () async {
                        final selectedTime = await TimePicker.showTimePicker(
                          context,
                          initialValue: intervals[intervalIndex],
                          timeRange: amrapWorkTimes,
                        );
                        if (selectedTime != null) {
                          amrap.setInterval(roundIndex, intervalIndex, selectedTime);
                        }
                      },
                    );
                  }),
                ],
              ),
              if (!isFirst)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
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
  }
}
