import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName("FavoriteWorkoutRawData")
class FavoriteWorkouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get workout => text()();
  TextColumn get timerType => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
}

@DataClassName("TrainingHistoryRawData")
class TrainingHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get startAt => integer()();
  IntColumn get endAt => integer()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get wellBeing => integer().nullable()();
  TextColumn get workout => text()();
  TextColumn get timerType => text()();
  TextColumn get intervals => text()();
  TextColumn get pauses => text().nullable()();
}

@DriftDatabase(tables: [FavoriteWorkouts, TrainingHistory])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'easytimer.db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
