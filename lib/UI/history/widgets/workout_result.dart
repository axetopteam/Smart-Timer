import 'package:flutter/cupertino.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/sdk/models/protos/emom/emom_extension.dart';
import 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings.pb.dart';
import 'package:smart_timer/sdk/models/training_history_record.dart';
import 'package:smart_timer/utils/duration.extension.dart';

class WorkoutResult extends StatefulWidget {
  const WorkoutResult(this.record, {super.key});
  final TrainingHistoryRecord record;

  @override
  State<WorkoutResult> createState() => _WorkoutResultState();
}

class _WorkoutResultState extends State<WorkoutResult> {
  @override
  Widget build(BuildContext context) {
    final workoutType = widget.record.workout.whichWorkout();
    final Widget child;
    switch (workoutType) {
      case WorkoutSettings_Workout.emom:
        child = _buildEmom();
      case WorkoutSettings_Workout.amrap:
        child = _buildAmrap();
      case WorkoutSettings_Workout.afap:
        child = _buildAfap();
      case WorkoutSettings_Workout.tabata:
        child = _buildTabata();
      case WorkoutSettings_Workout.workRest:
        child = _buildWorkRest();
      case WorkoutSettings_Workout.notSet:
        child = Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: context.color.containerBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget _buildAmrap() {
    final amraps = widget.record.workout.amrap.amraps;
    final children = <TableRow>[];

    for (int index = 0; index < amraps.length; index++) {
      final realSetDuration = widget.record.realSetDuration(index);

      children.add(
        _tableRow(
          title: '${widget.record.timerType.readbleName} ${index + 1}:',
          value: realSetDuration.$1.format,
        ),
      );
      if (index != amraps.length - 1) {
        children.add(
          _tableRow(
            title: 'Rest:',
            value: realSetDuration.$2.format,
          ),
        );
      }
    }

    return Table(
      children: children,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
    );
  }

  Widget _buildAfap() {
    final afaps = widget.record.workout.afap.afaps;

    final children = <TableRow>[];

    for (int index = 0; index < afaps.length; index++) {
      final realSetDuration = widget.record.realSetDuration(index);

      children.add(
        _tableRow(
          title: '${widget.record.timerType.readbleName} ${index + 1}:',
          value: realSetDuration.$1.format,
        ),
      );
      if (index != afaps.length - 1) {
        children.add(
          _tableRow(
            title: 'Rest:',
            value: realSetDuration.$2.format,
          ),
        );
      }
    }

    return Table(
      children: children,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
    );
  }

  Widget _buildEmom() {
    final emoms = widget.record.workout.emom.emoms;

    final children = <TableRow>[];

    for (int index = 0; index < emoms.length; index++) {
      final realSetDuration = widget.record.realSetDuration(index);
      final emom = emoms[index];
      final description = emom.deathBy
          ? 'Every ${emom.workTime.format} As Long As Possible'
          : '${emom.roundsCount} rounds every ${emom.workTime.format}';

      children.add(
        _tableRow(
          title: '${widget.record.timerType.readbleName} ${index + 1}:',
          description: description,
          value: realSetDuration.$1.format,
        ),
      );
      if (index != emoms.length - 1) {
        children.add(
          _tableRow(
            title: 'Rest:',
            description: '',
            value: realSetDuration.$2.format,
          ),
        );
      }
    }
    return Table(
      children: children,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
    );
  }

  Widget _buildTabata() {
    final tabats = widget.record.workout.tabata.tabats;

    final children = <TableRow>[];

    for (int index = 0; index < tabats.length; index++) {
      final realSetDuration = widget.record.realSetDuration(index);
      final tabata = tabats[index];
      final description = '${tabata.roundsCount} x (${tabata.workTime.format}/${tabata.restTime.format})';

      children.add(
        _tableRow(
          title: '${widget.record.timerType.readbleName} ${index + 1}:',
          description: description,
          value: realSetDuration.$1.format,
        ),
      );
      if (index != tabats.length - 1) {
        children.add(
          _tableRow(
            title: 'Rest:',
            description: '',
            value: realSetDuration.$2.format,
          ),
        );
      }
    }
    return Table(
      children: children,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
    );
  }

  Widget _buildWorkRest() {
    final sets = widget.record.workout.workRest.workRests;
    final children = <TableRow>[];
    for (int index = 0; index < sets.length; index++) {
      final realSetDuration = widget.record.realSetDuration(index);
      final roundsDuration = widget.record.workRestRoundsDuration(index);

      for (var j = 0; j < roundsDuration.length; j++) {
        children.add(
          _tableRow(
            title: 'Round ${j + 1}:',
            // title: '',
            value: roundsDuration[j].format,
          ),
        );
      }
      if (index != sets.length - 1) {
        children.add(
          _tableRow(
            title: 'Rest:',
            description: '',
            value: realSetDuration.$2.format,
          ),
        );
      }
    }
    return Table(
      children: children,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
    );
  }

  TableRow _tableRow({required String title, required String value, String? description}) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4, right: 8),
            child: Text(
              title,
            ),
          ),
        ),
        if (description != null) Text(description),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(value),
          ),
        ),
      ],
    );
  }
}

extension DurationResult on Duration {
  String get format {
    if (inMicroseconds < 0) {
      return "-${(-this).format}";
    }
    final milliseconds = inSeconds != 0 ? inMilliseconds.remainder(inSeconds * 1000) : inMilliseconds;
    final millisecondsString = milliseconds != 0 ? ',$milliseconds' : '';

    String twoDigitMinutes = twoDigits(inMinutes);

    String twoDigitSeconds = twoDigits(inSeconds.remainder(secondsPerMinute));

    return "$twoDigitMinutes:$twoDigitSeconds$millisecondsString";
  }
}
