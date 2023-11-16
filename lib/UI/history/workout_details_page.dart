import 'package:auto_route/annotations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_timer/UI/timer_types/emom/emom_state.dart';
import 'package:smart_timer/core/context_extension.dart';
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
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                    SizedBox(height: 20),
                    _buildItem(CupertinoIcons.time, 'Начало', Jiffy.parseFromDateTime(record.startAt.toLocal()).jm),
                    const SizedBox(height: 12),
                    _buildItem(CupertinoIcons.timer, 'Общее время', record.realDuration.durationToString()),
                    _buildName(),
                    _buildDescription(),
                    const SizedBox(height: 20),
                    Text('Детали тренировки'),
                    SizedBox(height: 12),
                    _buildSets(),
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
        Icon(icon),
        SizedBox(width: 4),
        Text(title),
        Spacer(),
        Text(value),
      ],
    );
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name:'),
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
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description:'),
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

  Widget _buildSets() {
    final workoutType = record.workout.whichWorkout();

    switch (workoutType) {
      case WorkoutSettings_Workout.emom:
        return _buildEmomResult(record.workout.emom.emoms);
      case WorkoutSettings_Workout.amrap:
        final amraps = record.workout.amrap.amraps;
        return Column(
            children: amraps
                .mapIndexed(
                  (index, e) => Column(
                    children: [
                      _buildTime('${widget.record.timerType.readbleName} ${index + 1}:', e.workTime.durationToString()),
                      if (index != amraps.length - 1) _buildTime('Rest:', e.restTime.durationToString()),
                    ],
                  ),
                )
                .toList());
      case WorkoutSettings_Workout.afap:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.tabata:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.workRest:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.notSet:
        return SliverToBoxAdapter(child: Container());
    }
  }

  Widget _buildTime(String title, String value) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 20),
        Text(
          value,
        ),
      ],
    );
  }

  Widget _buildEmomResult(List<Emom> emoms) {
    return Column(
      children: emoms.mapIndexed((index, emom) {
        final int? roundsCount;
        if (emom.deathBy) {
          final interval = record.intervals
              .lastWhere((element) => element.indexes.firstOrNull?.index == index + 1 && element.indexes.length == 2);
          roundsCount = interval.indexes.last.index;
        } else {
          roundsCount = emom.roundsCount;
        }
        return Column(
          children: [
            _buildTime('${widget.record.timerType.readbleName} ${index + 1}:',
                '$roundsCount x ${emom.workTime.durationToString()}'),
            if (index != emoms.length - 1) _buildTime('Rest:', emom.restAfterSet.durationToString()),
          ],
        );
      }).toList(),
    );
  }
}
