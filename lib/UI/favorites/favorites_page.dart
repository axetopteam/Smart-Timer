import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_timer/UI/favorites/favorites_state.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/purchasing/adapty_profile_state.dart';
import 'package:smart_timer/routes/router.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

import '../widgets/workout_filter_chip.dart';
import 'widgets/favorite_tile.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  SdkService get _sdk => GetIt.I();

  final state = FavoritesState();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Observer(builder: (context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: WorkoutFilterChip(
                selectedType: state.selectedType,
                onSelect: state.selectType,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                StreamBuilder(
                    stream: _sdk.favoritesStream(state.selectedType),
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
                        separatorBuilder: (_, __) => const Divider(height: 2, thickness: 2),
                        itemBuilder: (ctx, index) {
                          final favorite = favorites[index];
                          return Slidable(
                            key: ValueKey(favorite.id),
                            endActionPane: ActionPane(
                              extentRatio: .25,
                              dismissible: DismissiblePane(onDismissed: () {
                                _sdk.deleteFavorite(favorite.id);
                              }),
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  onPressed: (_) {
                                    _sdk.deleteFavorite(favorite.id);
                                  },
                                  backgroundColor: context.color.warning,
                                  foregroundColor: Colors.white,
                                  icon: CupertinoIcons.delete,
                                ),
                              ],
                            ),
                            child: FavoriteTile(
                              favorite: favorite,
                              onTap: _onTap,
                            ),
                          );
                        },
                      );
                    }),
                SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 20)),
              ],
            ),
          ),
        ],
      );
    });
  }

  void _onTap(FavoriteWorkout favoriteWorkout) async {
    final premiumState = context.read<AdaptyProfileState>();
    final router = context.router;
    if (!premiumState.isPremiumActive) {
      final hasPremium = await router.push<bool>(const PaywallRoute()) ?? false;
      if (!hasPremium) {
        return;
      }
    }
    final workoutSettings = favoriteWorkout.workoutSettings;
    switch (workoutSettings.whichWorkout()) {
      case WorkoutSettings_Workout.amrap:
        await router.push(AmrapRoute(amrapSettings: workoutSettings.amrap));
      case WorkoutSettings_Workout.afap:
        await router.push(AfapRoute(afapSettings: workoutSettings.afap));
      case WorkoutSettings_Workout.emom:
        await router.push(EmomRoute(emomSettings: workoutSettings.emom));
      case WorkoutSettings_Workout.tabata:
        await router.push(TabataRoute(tabataSettings: workoutSettings.tabata));
      case WorkoutSettings_Workout.workRest:
        await router.push(WorkRestRoute(workRestSettings: workoutSettings.workRest));
      case WorkoutSettings_Workout.notSet:
    }
  }
}
