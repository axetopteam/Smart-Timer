import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_timer/UI/timer_types/afap/afap_state.dart';
import 'package:smart_timer/UI/timer_types/emom/emom_state.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/sdk/models/favorite_workout.dart';
import 'package:smart_timer/sdk/models/protos/amrap/amrap_extension.dart';
import 'package:smart_timer/sdk/models/protos/tabata/tabata_extension.dart';
import 'package:smart_timer/sdk/models/protos/work_rest/work_rest_extension.dart';
import 'package:smart_timer/utils/duration.extension.dart';

class FavoriteTile extends StatefulWidget {
  const FavoriteTile({required this.favorite, required this.onTap, super.key});
  final FavoriteWorkout favorite;
  final void Function(FavoriteWorkout) onTap;

  @override
  State<FavoriteTile> createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      leading: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.favorite.type.workoutColor(context),
          shape: BoxShape.circle,
        ),
        child: const SizedBox.expand(),
      ),
      leadingToTitle: 12,
      onTap: () => widget.onTap(widget.favorite),
      title: Text(widget.favorite.readbleName),
      subtitle: _buildSubtitle(widget.favorite.workoutSettings),
    );
  }

  Widget _buildSubtitle(WorkoutSettings workoutSettings) {
    switch (workoutSettings.whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        final amraps = workoutSettings.amrap.amraps;
        final chilren = <Widget>[];
        amraps.forEachIndexed(
          (index, amrap) {
            chilren.add(DescriptionItem(
              value: amrap.workTime.shortFormat,
              color: widget.favorite.type.workoutColor(context),
            ));

            if (index != amraps.length - 1) {
              chilren.add(DescriptionItem(
                value: amrap.restTime.shortFormat,
                color: context.color.warning,
              ));
            }
          },
        );
        return Wrap(
          runSpacing: 4,
          spacing: 4,
          children: chilren,
        );

      // return buffer.toString();
      case WorkoutSettings_Workout.afap:
        final sets = workoutSettings.afap.afaps;
        final chilren = <Widget>[];
        sets.forEachIndexed(
          (index, set) {
            chilren.add(DescriptionItem(
              value: set.timeCap.shortFormat,
              color: widget.favorite.type.workoutColor(context),
            ));

            if (index != sets.length - 1) {
              chilren.add(DescriptionItem(
                value: set.restTime.shortFormat,
                color: context.color.warning,
              ));
            }
          },
        );
        return Wrap(
          runSpacing: 4,
          spacing: 4,
          children: chilren,
        );
      case WorkoutSettings_Workout.emom:
        final sets = workoutSettings.emom.emoms;
        final chilren = <Widget>[];
        sets.forEachIndexed(
          (index, set) {
            final String title = set.deathBy
                ? 'Every ${set.workTime.shortFormat} as long as possible'
                : '${set.roundsCount} rounds every ${set.workTime.shortFormat}';

            chilren.add(DescriptionItem(
              value: title,
              color: widget.favorite.type.workoutColor(context),
            ));

            if (index != sets.length - 1) {
              chilren.add(DescriptionItem(
                value: set.restAfterSet.shortFormat,
                color: context.color.warning,
              ));
            }
          },
        );
        return Wrap(
          runSpacing: 4,
          spacing: 4,
          children: chilren,
        );
      case WorkoutSettings_Workout.tabata:
        final sets = workoutSettings.tabata.tabats;
        final chilren = <Widget>[];
        sets.forEachIndexed(
          (index, set) {
            final String title =
                '${set.roundsCount} rounds ${set.workTime.shortFormat} work / ${set.restTime.shortFormat} rest';

            chilren.add(DescriptionItem(
              value: title,
              color: widget.favorite.type.workoutColor(context),
            ));

            if (index != sets.length - 1) {
              chilren.add(DescriptionItem(
                value: set.restAfterSet.shortFormat,
                color: context.color.warning,
              ));
            }
          },
        );
        return Wrap(
          runSpacing: 4,
          spacing: 4,
          children: chilren,
        );

      case WorkoutSettings_Workout.workRest:
        final sets = workoutSettings.workRest.workRests;
        final chilren = <Widget>[];
        sets.forEachIndexed(
          (index, set) {
            double ratioFraction = set.ratio - set.ratio.truncate();
            final ratio = ratioFraction == 0 ? set.ratio.toInt() : set.ratio;

            final String title = '${set.roundsCount} rounds, work/rest: $ratio';
            chilren.add(DescriptionItem(
              value: title,
              color: widget.favorite.type.workoutColor(context),
            ));

            if (index != sets.length - 1) {
              chilren.add(DescriptionItem(
                value: set.restAfterSet.shortFormat,
                color: context.color.warning,
              ));
            }
          },
        );
        return Wrap(
          runSpacing: 4,
          spacing: 4,
          children: chilren,
        );
      case WorkoutSettings_Workout.notSet:
        return Container();
    }
  }
}

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({required this.value, required this.color, super.key});
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        value,
        style: context.textStyles.chip,
      ),
    );
  }
}
