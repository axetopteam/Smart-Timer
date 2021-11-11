import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/time_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/routes/router_interface.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/stores/amrap.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

class AmrapPage extends StatefulWidget {
  const AmrapPage({Key? key}) : super(key: key);

  @override
  State<AmrapPage> createState() => _AmrapPageState();
}

class _AmrapPageState extends State<AmrapPage> {
  late final Amrap amrap;

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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Observer(
          builder: (ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              const Text(
                'AMRAP',
                style: AppFonts.header,
              ),
              const SizedBox(height: 32),
              const Text(
                'As many rounds as possible in',
                style: AppFonts.header2,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  children: [
                    ...amrap.rounds.asMap().keys.map(
                      (roundIndex) {
                        return buildRound(roundIndex);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        amrap.addRound();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.add_circle_outline,
                            size: 28,
                            color: AppColors.accentBlue,
                          ),
                          SizedBox(width: 4),
                          Text('Add another AMRAP')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MainButton(
                  child: const Text(
                    'START TIMER',
                    style: AppFonts.buttonTitle,
                  ),
                  borderRadius: 20,
                  onPressed: () {
                    getIt<RouterInterface>().showTimer(amrap.workout);
                  },
                  color: AppColors.accentBlue,
                ),
              )
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

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 200,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Text('AMRAP ${roundIndex + 1}'),
            const SizedBox(height: 8),
            ...intervals.asMap().keys.map(
              (intervalIndex) {
                if (isLast && intervalIndex == 1) return Container();
                return Container(
                  width: 120,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        intervalIndex == 0 ? 'Work:' : 'Rest',
                        style: AppFonts.body,
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
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
                        child: ValueContainer(
                          durationToString2(intervals[intervalIndex]),
                          width: 60,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ]),
        ),
        if (!isFirst)
          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              onPressed: () {
                amrap.deleteRound(roundIndex);
              },
              icon: const Icon(
                Icons.close_sharp,
                color: AppColors.red,
              ),
            ),
          ),
      ],
    );
  }
}
