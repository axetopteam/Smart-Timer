import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/bottom_sheets/time_picker/time_picker.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/utils/string_utils.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            const Text(
              'FOR TIME',
              style: AppFonts.header,
            ),
            const SizedBox(height: 32),
            const Text(
              'As fast as possible for time',
              style: AppFonts.header2,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Observer(builder: (context) {
                return Column(
                  children: [
                    ...afap.rounds.asMap().keys.map(
                      (roundIndex) {
                        return buildRound(roundIndex);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        afap.addRound();
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
                          Text('Add another AFAP')
                        ],
                      ),
                    ),
                  ],
                );
              }),
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
                  //TODO: replace with new router
                },
                color: AppColors.accentBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRound(int roundIndex) {
    final intervals = afap.rounds[roundIndex];
    bool isLast = roundIndex == afap.roundsCound - 1;
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
          child: Observer(
            builder: (ctx) => Column(children: [
              Text('Round ${roundIndex + 1}'),
              const SizedBox(height: 8),
              ...intervals.asMap().keys.map(
                (intervalIndex) {
                  final interval = intervals[intervalIndex];
                  if (isLast && intervalIndex == 1) return Container();
                  return Container(
                    width: 150,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          intervalIndex == 0 ? 'Time cap:' : 'Rest',
                          style: AppFonts.body,
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () async {
                            final selectedTime = await TimePicker.showTimePicker(
                              context,
                              initialDuration: interval,
                            );
                            afap.setInterval(roundIndex, intervalIndex, selectedTime);
                          },
                          child: ValueContainer(
                            interval != null ? durationToString2(interval) : 'None',
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
        ),
        if (!isFirst)
          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              onPressed: () {
                afap.deleteRound(roundIndex);
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
