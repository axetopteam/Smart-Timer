import 'package:flutter/material.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/sdk/models/workout_set.dart';
// import 'package:smart_timer/models/workout.dart';

class WorkoutDesc extends StatelessWidget {
  WorkoutDesc(this.workout, {Key? key}) : super(key: key) {
    workout.start(DateTime(0));
  }
  final WorkoutSet workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              workout.toString(),
              style: context.textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
