import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/core/app_theme/app_theme.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/routes/main_auto_router.gr.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/stores/amrap.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/start_button.dart';

class AmrapPage extends StatefulWidget {
  const AmrapPage({Key? key}) : super(key: key);

  @override
  State<AmrapPage> createState() => _AmrapPageState();
}

class _AmrapPageState extends State<AmrapPage> {
  late final Amrap amrap;

  AppTheme get theme => GetIt.I<AppTheme>();

  @override
  void initState() {
    final json = getIt<AppProperties>().getAmrapSettings();
    amrap = json != null ? Amrap.fromJson(json) : Amrap();

    super.initState();
  }

  @override
  void dispose() {
    final json = amrap.toJson();
    getIt<AppProperties>().setAmrapSettings(json);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.amrapColor,
        title: const Text('AMRAP'),
      ),
      body: SafeArea(
        child: Observer(
          builder: (ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: theme.colorScheme.amrapColor,
                padding: const EdgeInsets.only(bottom: 30),
                child: const Padding(
                  padding: EdgeInsets.only(left: 94),
                  child: Text(
                    'Repeat as many rounds as\npossible for selected time',
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...amrap.rounds.asMap().keys.map(
                        (roundIndex) {
                          return buildRound(roundIndex);
                        },
                      ),
                      const SizedBox(height: 26),
                      Padding(
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
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: StartButton(
                    backgroundColor: theme.colorScheme.amrapColor,
                    //TODO: replace with new router

                    onPressed: () => getIt<AppRouter>().push(TimerRoute(workout: amrap.workout))
                    //  getIt<RouterInterface>().showTimer(amrap.workout),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRound(int roundIndex) {
    final intervals = amrap.rounds[roundIndex];
    bool isLast = roundIndex == amrap.roundsCound - 1;
    bool isFirst = roundIndex == 0;

    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, isFirst ? 34 : 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.primaryVariant, width: 5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AMRAP ${roundIndex + 1}'),
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
              child: TextButton(
                onPressed: () {
                  amrap.deleteRound(roundIndex);
                },
                child: Row(
                  children: [
                    Text(
                      'Remove AMRAP ${roundIndex + 1}',
                      style: TextStyle(color: theme.colorScheme.secondary),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
