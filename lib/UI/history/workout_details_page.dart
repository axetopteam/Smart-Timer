import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_timer/UI/history/history_state.dart';
import 'package:smart_timer/UI/timer_types/emom/emom_state.dart';
import 'package:smart_timer/UI/timer_types/tabata/tabata_state.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/models/protos/amrap/amrap_extension.dart';
import 'package:smart_timer/sdk/sdk_service.dart';
import 'package:smart_timer/utils/duration.extension.dart';

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
    return Material(
      child: CupertinoPageScaffold(
        child: Builder(builder: (context) {
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                stretch: true,
                largeTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.record.readbleName,
                    ),
                  ],
                ),
                alwaysShowMiddle: false,
                middle: Text(widget.record.readbleName),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.list(
                  children: [
                    Text(
                      Jiffy.parseFromDateTime(record.startAt.toLocal()).yMEd,
                      style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                    ),
                    const SizedBox(height: 20),
                    _buildItem(CupertinoIcons.time, LocaleKeys.history_start_time.tr(),
                        Jiffy.parseFromDateTime(record.startAt.toLocal()).jm),
                    const SizedBox(height: 12),
                    _buildItem(CupertinoIcons.timer, LocaleKeys.history_total_time.tr(),
                        record.realDuration.durationToString()),
                    _buildName(),
                    _buildDescription(),
                    const SizedBox(height: 20),
                    Text(
                      LocaleKeys.history_results_title.tr(),
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 12),
                    _buildSets(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(record.timerType.workoutColor(context))),
                        onPressed: _repeat,
                        child: Text('Повторить тренировку'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: context.textTheme.bodyLarge,
        ),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.history_name.tr(),
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          CupertinoTextField(
            controller: _nameController,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.color.borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.history_description.tr(),
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          CupertinoTextField(
            decoration: BoxDecoration(
              border: Border.all(
                color: context.color.borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            controller: _descriptionController,
            maxLines: null,
            expands: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTime(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            value,
          ),
        ),
      ],
    );
  }

  Widget _buildSets() {
    final workoutType = record.workout.whichWorkout();

    switch (workoutType) {
      case WorkoutSettings_Workout.emom:
        return _buildEmom(record.workout.emom.emoms);
      case WorkoutSettings_Workout.amrap:
        return _buildAmrap();
      case WorkoutSettings_Workout.afap:
        return _buildAfap();
      case WorkoutSettings_Workout.tabata:
        return _buildTabata();
      case WorkoutSettings_Workout.workRest:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.notSet:
        return Container();
    }
  }

  Widget _buildTabata() {
    final tabats = record.workout.tabata.tabats;
    return Column(
      children: tabats.mapIndexed((index, tabata) {
        final realSetDuration = record.realSetDuration(index);
        return Column(
          children: [
            _buildTime('${widget.record.timerType.readbleName} ${index + 1}:',
                '${tabata.roundsCount} x (${tabata.workTime.durationToString()}/${tabata.restTime.durationToString()}) (${realSetDuration.$1.durationToString()})'),
            if (index != tabats.length - 1) _buildTime('Rest:', realSetDuration.$2.durationToString()),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildAfap() {
    final afaps = record.workout.afap.afaps;

    return Column(
        children: afaps.mapIndexed((index, e) {
      final realSetDuration = record.realSetDuration(index);

      return Column(
        children: [
          _buildTime(
              '${widget.record.timerType.readbleName} ${index + 1}:', '  ${realSetDuration.$1.durationToString()}'),
          if (index != afaps.length - 1) _buildTime('Rest:', realSetDuration.$2.durationToString()),
        ],
      );
    }).toList());
  }

  Widget _buildAmrap() {
    final amraps = record.workout.amrap.amraps;

    return Column(
        children: amraps.mapIndexed((index, e) {
      final realSetDuration = record.realSetDuration(index);

      return Column(
        children: [
          _buildTime('${widget.record.timerType.readbleName} ${index + 1}:',
              '${e.workTime.durationToString()}  ${(realSetDuration.$1) < e.workTime ? realSetDuration.$1.durationToString() : ''}'),
          if (index != amraps.length - 1)
            _buildTime('Rest:',
                '${e.restTime.durationToString()}  ${(realSetDuration.$2) < e.restTime ? realSetDuration.$2.durationToString() : ''}'),
        ],
      );
    }).toList());
  }

  Widget _buildEmom(List<Emom> emoms) {
    return Column(
      children: emoms.mapIndexed((index, emom) {
        final realSetDuration = record.realSetDuration(index);

        return Column(
          children: [
            if (emom.deathBy)
              _buildTime('${widget.record.timerType.readbleName} ${index + 1}:',
                  'Every ${emom.workTime.durationToString()} As Long As Possible (${realSetDuration.$1.durationToString()})'),
            if (!emom.deathBy)
              _buildTime('${widget.record.timerType.readbleName} ${index + 1}:',
                  '${emom.roundsCount} x ${emom.workTime.durationToString()} (${realSetDuration.$1.durationToString()})'),
            if (index != emoms.length - 1) _buildTime('Rest:', realSetDuration.$2.durationToString()),
          ],
        );
      }).toList(),
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
