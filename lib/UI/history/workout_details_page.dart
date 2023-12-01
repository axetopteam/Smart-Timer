import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_timer/UI/history/history_state.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import 'widgets/workout_result.dart';

export 'package:smart_timer/sdk/models/training_history_record.dart';

@RoutePage()
class WorkoutDetailsPage extends StatefulWidget {
  const WorkoutDetailsPage(this.record, {super.key});
  final TrainingHistoryRecord record;

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = record.name;
    _descriptionController.text = record.description;
    super.initState();
  }

  @override
  void dispose() {
    _save();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await GetIt.I<HistoryState>().updateRecord(
      id: record.id,
      name: _nameController.text,
      description: _descriptionController.text,
    );
  }

  TrainingHistoryRecord get record => widget.record;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bottomPadding = max(mq.viewInsets.bottom, mq.padding.bottom) + 20;
    return Material(
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: GestureDetector(
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child: Column(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    return CustomScrollView(
                      slivers: [
                        CupertinoSliverNavigationBar(
                          stretch: true,
                          largeTitle: Text(
                            widget.record.readbleName,
                          ),
                        ),
                        SliverList.list(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                Jiffy.parseFromDateTime(record.startAt.toLocal()).yMEd,
                                style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildCommonInfo(),
                            const SizedBox(height: 32),
                            _buildNotes(),
                            const SizedBox(height: 32),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      LocaleKeys.history_results_title.tr().toUpperCase(),
                                      style: context.textStyles.cupertinoSectionTitle,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  WorkoutResult(
                                    record,
                                    showRestIntervals: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPadding),
                child: ElevatedButtonTheme(
                  data: context.buttonThemes.startButtonTheme,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(record.timerType.workoutColor(context)),
                      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56)),
                    ),
                    onPressed: _repeat,
                    child: Text(LocaleKeys.history_repeat_workout.tr()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommonInfo() {
    return CupertinoListSection.insetGrouped(
      backgroundColor: context.color.background,
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      decoration: BoxDecoration(
        color: context.color.containerBackground,
      ),
      children: [
        CupertinoListTile.notched(
          title: Text(LocaleKeys.history_start_time.tr()),
          leading: const Icon(CupertinoIcons.time),
          trailing: Text(
            Jiffy.parseFromDateTime(record.startAt.toLocal()).jm,
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ),
        CupertinoListTile.notched(
          title: Text(LocaleKeys.history_total_time.tr()),
          leading: const Icon(CupertinoIcons.timer),
          trailing: Text(
            record.realDuration.format,
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildNotes() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(LocaleKeys.history_notes.tr().toUpperCase(), style: context.textStyles.cupertinoSectionTitle),
          ),
          const SizedBox(height: 10),
          CupertinoTextField(
            decoration: BoxDecoration(
              border: Border.all(
                color: context.color.borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            controller: _descriptionController,
            placeholder: LocaleKeys.history_notes_hint.tr(),
            padding: const EdgeInsets.fromLTRB(16, 7, 16, 7),
            maxLines: null,
            expands: true,
          ),
        ],
      ),
    );
  }

  void _repeat() {
    final workoutSettings = record.workout;
    switch (workoutSettings.whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        context.pushRoute(AmrapRoute(amrapSettings: workoutSettings.amrap));
      case WorkoutSettings_Workout.afap:
        context.pushRoute(AfapRoute(afapSettings: workoutSettings.afap));
      case WorkoutSettings_Workout.emom:
        context.pushRoute(EmomRoute(emomSettings: workoutSettings.emom));
      case WorkoutSettings_Workout.tabata:
        context.pushRoute(TabataRoute(tabataSettings: workoutSettings.tabata));
      case WorkoutSettings_Workout.workRest:
        context.pushRoute(WorkRestRoute(workRestSettings: workoutSettings.workRest));
      case WorkoutSettings_Workout.notSet:
    }
  }
}
