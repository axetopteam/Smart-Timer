import 'package:auto_route/auto_route.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';

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
    return Scaffold(
      body: Observer(builder: (context) {
        final favorites = _state.favorites;
        if (favorites != null) {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                onTap: () => onTap(favorites[index]),
                title: Text(
                  HexUtils.encode(favorites[index].workoutSettings.writeToBuffer()),
                ),
                textColor: context.color.mainText,
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
      // TODO: Handle this case.
      case WorkoutSettings_Workout.emom:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.tabata:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.workRest:
      // TODO: Handle this case.
      case WorkoutSettings_Workout.notSet:
      // TODO: Handle this case.
    }
  }
}
