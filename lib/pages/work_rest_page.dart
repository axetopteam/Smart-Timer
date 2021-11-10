import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/application/constants.dart';
import 'package:smart_timer/helpers/rounds_picker.dart';
import 'package:smart_timer/main.dart';
import 'package:smart_timer/routes/router_interface.dart';
import 'package:smart_timer/services/app_properties.dart';
import 'package:smart_timer/stores/work_rest.dart';
import 'package:smart_timer/widgets/main_button.dart';
import 'package:smart_timer/widgets/value_container.dart';

class WorkRestPage extends StatefulWidget {
  const WorkRestPage({Key? key}) : super(key: key);

  @override
  State<WorkRestPage> createState() => _WorkRestPageState();
}

class _WorkRestPageState extends State<WorkRestPage> {
  late final WorkRest workRest;

  @override
  void initState() {
    final settingsJson = getIt<AppProperties>().getWorkRestSettings();
    workRest = settingsJson != null ? WorkRest.fromJson(settingsJson) : WorkRest();
    super.initState();
  }

  @override
  void dispose() {
    final json = workRest.toJson();
    getIt<AppProperties>().setWorkRestSettings(json);
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
                    getIt.get<RouterInterface>().showTimer(workRest.workout);
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
