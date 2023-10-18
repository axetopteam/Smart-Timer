import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

@RoutePage<void>()
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  SdkService get _sdk => GetIt.I();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _sdk.favoritesStream(),
        builder: (context, snapshot) {
          final favorites = snapshot.data;

          if (favorites != null) {
            return ListView.separated(
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const Divider(height: 8, thickness: 2),
              itemBuilder: (ctx, index) {
                final favorite = favorites[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        onPressed: (_) {
                          _sdk.deleteFavorite(favorite.id);
                        },
                        backgroundColor: context.color.warning,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  key: ValueKey(favorite.id),
                  child: CupertinoListTile(
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
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator.adaptive();
        },
      ),
    );
  }

  void onTap(FavoriteWorkout favoriteWorkout) {
    final workoutSettings = favoriteWorkout.workoutSettings;
    final j = workoutSettings.whichWorkout();
    j.name;
    switch (workoutSettings.whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        context.pushRoute(NewTimerRouter(children: [AmrapRoute(amrapSettings: workoutSettings.amrap)]));
      case WorkoutSettings_Workout.afap:
        context.pushRoute(NewTimerRouter(children: [AfapRoute(afapSettings: workoutSettings.afap)]));
      case WorkoutSettings_Workout.emom:
        context.pushRoute(NewTimerRouter(children: [EmomRoute(emomSettings: workoutSettings.emom)]));
      case WorkoutSettings_Workout.tabata:
        context.pushRoute(NewTimerRouter(children: [TabataRoute(tabataSettings: workoutSettings.tabata)]));
      case WorkoutSettings_Workout.workRest:
        context.pushRoute(NewTimerRouter(children: [WorkRestRoute(workRestSettings: workoutSettings.workRest)]));
      case WorkoutSettings_Workout.notSet:
    }
  }
}
