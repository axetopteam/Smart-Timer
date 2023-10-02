import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';

import 'favorites_state.dart';

@RoutePage<void>()
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final _state = FavoritesState();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Favorites'),
      ),
      child: Observer(builder: (context) {
        final favorites = _state.favorites;
        if (favorites != null) {
          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (context, index) => const Divider(height: 2, thickness: 2),
            itemBuilder: (ctx, index) {
              final favorite = favorites[index];
              return CupertinoListTile(
                leading: ColoredBox(
                  color: favorite.type.workoutColor(context),
                  child: const SizedBox.expand(),
                ),
                leadingToTitle: 12,
                onTap: () => onTap(favorite),
                title: Text(
                  favorite.workoutSettings.description,
                ),
                subtitle: Text(favorite.name),
                // textColor: context.color.mainText,
              );
            },
          );
        }
        return const CircularProgressIndicator.adaptive();
      }),
    );
  }

  void onTap(FavoriteWorkout favoriteWorkout) {
    final workoutSettings = favoriteWorkout.workoutSettings;
    final j = workoutSettings.whichWorkout();
    j.name;
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
