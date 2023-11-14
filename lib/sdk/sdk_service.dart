import 'dart:convert';

import 'package:smart_timer/sdk/db/queries.database.dart';
import 'package:smart_timer/sdk/models/training_history_record.dart';
import 'package:smart_timer/sdk/workout_parser.dart';

import 'db/database.dart';
import 'models/favorite_workout.dart';

export 'models/favorite_workout.dart';
export 'models/training_history_record.dart';

part 'favorites.service.dart';
part 'history.service.dart';

class SdkService {
  SdkService({required AppDatabase db}) : _db = db;
  final AppDatabase _db;
}
