import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/bottom_sheets/rounds_picker.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/timer/timer_state.dart';
import 'package:smart_timer/timer/timer_type.dart';
import 'package:smart_timer/widgets/interval_widget.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/quantity_widget.dart';
import 'package:smart_timer/widgets/timer_setup_scaffold.dart';
import 'package:smart_timer/widgets/value_container.dart';

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
      appBarTitle: 'Work : Rest',
      subtitle: 'Repeat several rounds every minute on minute',
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
                    QuantityWidget(
                      title: 'Rounds',
                      quantity: workRest.roundsCount,
                      onTap: () async {
                        final ratio = await RoundsPicker.showRoundsPicker(
                          context,
                          initialValue: workRest.ratio,
                          range: tabataRounds, //TODO: set rounds range
                        );
                        if (ratio != null) {
                          workRest.setRounds(ratio);
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    QuantityWidget(
                      title: 'Ratio:',
                      quantity: workRest.ratio,
                      onTap: () async {
                        final ratio = await RoundsPicker.showRoundsPicker(
                          context,
                          initialValue: workRest.ratio,
                          range: tabataRounds, //TODO: set ratio range
                        );
                        if (ratio != null) {
                          workRest.setRatio(ratio);
                        }
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              const Text(
                'Work-Rest',
                style: AppFonts.header,
              ),
              const SizedBox(height: 32),
              const Text(
                'Work and rest alternate with the established ratio',
                style: AppFonts.header2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rounds:',
                    style: AppFonts.body,
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      final selectedRounds = await RoundsPicker.showRoundsPicker(
                        context,
                        initialValue: workRest.roundsCount,
                        range: tabataRounds,
                      );
                      if (selectedRounds != null) {
                        workRest.setRounds(selectedRounds);
                      }
                    },
                    child: Observer(
                      builder: (ctx) => ValueContainer('${workRest.roundsCount}'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Ratio:',
                    style: AppFonts.body,
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      final selectedRatio = await RoundsPicker.showRoundsPicker(
                        context,
                        initialValue: workRest.ratio,
                        range: tabataRounds,
                      );
                      if (selectedRatio != null) {
                        workRest.setRatio(selectedRatio);
                      }
                    },
                    child: Observer(
                      builder: (ctx) => ValueContainer('${workRest.ratio}'),
                    ),
                  )
                ],
              ),
              const Spacer(),
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
                    // getIt.get<RouterInterface>().showTimer(workRest.workout);
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
}
