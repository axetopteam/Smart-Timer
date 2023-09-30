import 'package:auto_route/auto_route.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/routes/router.dart';

import '../sdk/models/protos/amrap_settings/amrap_settings.pb.dart';
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
                  favorites[index].workoutSettings.toString(),
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

  void onTap(FavoriteWorkout workout) {
    switch (workout.timerType) {
      case TimerType.amrap:
        context.pushRoute(AmrapRoute(amrapSettings: workout.workoutSettings as AmrapSettings));

      case TimerType.afap:
      // TODO: Handle this case.
      case TimerType.emom:
      // TODO: Handle this case.
      case TimerType.tabata:
      // TODO: Handle this case.
      case TimerType.workRest:
      // TODO: Handle this case.
    }
  }
}
