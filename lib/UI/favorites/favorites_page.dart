import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/models/protos/workout_settings/workout_settings_extension.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  SdkService get _sdk => GetIt.I();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StreamBuilder(
              stream: _sdk.favoritesStream(),
              builder: (context, snapshot) {
                final favorites = snapshot.data;

                if (favorites == null) {
                  return const SliverFillRemaining(child: CircularProgressIndicator.adaptive());
                }
                if (favorites.isEmpty) {
                  return SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 120),
                      child: Align(
                        child: Text(
                          LocaleKeys.favorites_empty.tr(),
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  );
                }

                return SliverList.separated(
                  itemCount: favorites.length,
                  separatorBuilder: (_, __) => const Divider(height: 12, thickness: 2),
                  itemBuilder: (ctx, index) {
                    final favorite = favorites[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: .25,
                        motion: const DrawerMotion(),
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
                        leading: DecoratedBox(
                          decoration: BoxDecoration(
                            color: favorite.type.workoutColor(context),
                            shape: BoxShape.circle,
                          ),
                          child: const SizedBox.expand(),
                        ),
                        leadingToTitle: 12,
                        onTap: () => onTap(favorite),
                        title: Text(favorite.readbleName),
                        subtitle: Text(
                          favorite.readbleDescription,
                          maxLines: 3,
                        ),
                      ),
                    );
                  },
                );
              }),
          SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 20)),
        ],
      ),
    );
  }

  void onTap(FavoriteWorkout favoriteWorkout) {
    final workoutSettings = favoriteWorkout.workoutSettings;
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
