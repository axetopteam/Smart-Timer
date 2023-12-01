import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_timer/core/app_theme/timer_icons_icons.dart';
import 'package:smart_timer/sdk/models/workout/workout.dart';
import '../favorites/add_to_favorites_alert.dart';
import '../pages/workout_desc.dart';
import 'start_button.dart';

class TimerSetupScaffold extends StatelessWidget {
  const TimerSetupScaffold({
    required this.color,
    required this.appBarTitle,
    required this.subtitle,
    required this.workout,
    required this.onStartPressed,
    required this.slivers,
    this.scrollController,
    this.addToFavorites,
    Key? key,
  }) : super(key: key);

  final Color color;
  final String appBarTitle;
  final String subtitle;
  final List<Widget> slivers;
  final Workout workout;
  final void Function() onStartPressed;
  final ScrollController? scrollController;
  final OnSaveFavorite? addToFavorites;

  @override
  Widget build(BuildContext context) {
    final safeOffset = MediaQuery.of(context).viewPadding;
    final bommomPadding = max(safeOffset.bottom, 34.0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  centerTitle: false,
                  title: Text(appBarTitle),
                  pinned: true,
                  backgroundColor: color,
                  expandedHeight: 120.0,
                  actions: [
                    if (addToFavorites != null)
                      IconButton(
                        onPressed: () {
                          AddToFavoritesAlert.show(context, addToFavorites: addToFavorites!);
                        },
                        icon: const Icon(TimerIcons.add_to_favorites),
                      ),
                    if (kDebugMode)
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                            return WorkoutDesc(workout);
                          }));
                        },
                        icon: const Icon(Icons.description_outlined),
                      ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 78, bottom: 20, right: 20),
                      child: Text(subtitle),
                    ),
                  ),
                ),
                ...slivers,
                SliverToBoxAdapter(child: SizedBox(height: bommomPadding + 100))
              ],
            ),
            Positioned(
              right: 30,
              left: 30,
              bottom: bommomPadding,
              child: StartButton(
                backgroundColor: color,
                totalTime: workout.totalDuration,
                onPressed: onStartPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
