import 'package:protobuf/protobuf.dart';
import 'package:smart_timer/sdk/db/queries.database.dart';
import 'package:smart_timer/sdk/workout_parser.dart';

import 'db/database.dart';
import 'models/favorite_workout.dart';

export 'models/favorite_workout.dart';

part 'database.service.dart';

class SdkService {
  SdkService({required AppDatabase db}) : _db = db;
  final AppDatabase _db;
}
