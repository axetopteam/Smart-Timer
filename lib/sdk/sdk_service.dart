import 'dart:convert';

import 'package:smart_timer/UI/timer_types/timer_settings_interface.dart';
import 'package:smart_timer/sdk/db/queries.database.dart';
import 'package:smart_timer/sdk/workout_parser.dart';

import 'db/database.dart';
import 'models/favorite_workout.dart';
import 'models/workout_set.dart';

export 'models/favorite_workout.dart';
export 'models/workout_set.dart';

part 'favorites.service.dart';
part 'history.service.dart';

class SdkService {
  SdkService({required AppDatabase db}) : _db = db;
  final AppDatabase _db;
}
