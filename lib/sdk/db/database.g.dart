// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteWorkoutsTable extends FavoriteWorkouts
    with TableInfo<$FavoriteWorkoutsTable, FavoriteWorkoutRawData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteWorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _workoutMeta =
      const VerificationMeta('workout');
  @override
  late final GeneratedColumn<String> workout = GeneratedColumn<String>(
      'workout', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timerTypeMeta =
      const VerificationMeta('timerType');
  @override
  late final GeneratedColumn<String> timerType = GeneratedColumn<String>(
      'timer_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, workout, timerType, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_workouts';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoriteWorkoutRawData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('workout')) {
      context.handle(_workoutMeta,
          workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta));
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('timer_type')) {
      context.handle(_timerTypeMeta,
          timerType.isAcceptableOrUnknown(data['timer_type']!, _timerTypeMeta));
    } else if (isInserting) {
      context.missing(_timerTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteWorkoutRawData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteWorkoutRawData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      workout: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workout'])!,
      timerType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timer_type'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $FavoriteWorkoutsTable createAlias(String alias) {
    return $FavoriteWorkoutsTable(attachedDatabase, alias);
  }
}

class FavoriteWorkoutRawData extends DataClass
    implements Insertable<FavoriteWorkoutRawData> {
  final int id;
  final String name;
  final String workout;
  final String timerType;
  final String description;
  const FavoriteWorkoutRawData(
      {required this.id,
      required this.name,
      required this.workout,
      required this.timerType,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['workout'] = Variable<String>(workout);
    map['timer_type'] = Variable<String>(timerType);
    map['description'] = Variable<String>(description);
    return map;
  }

  FavoriteWorkoutsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteWorkoutsCompanion(
      id: Value(id),
      name: Value(name),
      workout: Value(workout),
      timerType: Value(timerType),
      description: Value(description),
    );
  }

  factory FavoriteWorkoutRawData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteWorkoutRawData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      workout: serializer.fromJson<String>(json['workout']),
      timerType: serializer.fromJson<String>(json['timerType']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'workout': serializer.toJson<String>(workout),
      'timerType': serializer.toJson<String>(timerType),
      'description': serializer.toJson<String>(description),
    };
  }

  FavoriteWorkoutRawData copyWith(
          {int? id,
          String? name,
          String? workout,
          String? timerType,
          String? description}) =>
      FavoriteWorkoutRawData(
        id: id ?? this.id,
        name: name ?? this.name,
        workout: workout ?? this.workout,
        timerType: timerType ?? this.timerType,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteWorkoutRawData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('workout: $workout, ')
          ..write('timerType: $timerType, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, workout, timerType, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteWorkoutRawData &&
          other.id == this.id &&
          other.name == this.name &&
          other.workout == this.workout &&
          other.timerType == this.timerType &&
          other.description == this.description);
}

class FavoriteWorkoutsCompanion
    extends UpdateCompanion<FavoriteWorkoutRawData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> workout;
  final Value<String> timerType;
  final Value<String> description;
  const FavoriteWorkoutsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.workout = const Value.absent(),
    this.timerType = const Value.absent(),
    this.description = const Value.absent(),
  });
  FavoriteWorkoutsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String workout,
    required String timerType,
    this.description = const Value.absent(),
  })  : workout = Value(workout),
        timerType = Value(timerType);
  static Insertable<FavoriteWorkoutRawData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? workout,
    Expression<String>? timerType,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (workout != null) 'workout': workout,
      if (timerType != null) 'timer_type': timerType,
      if (description != null) 'description': description,
    });
  }

  FavoriteWorkoutsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? workout,
      Value<String>? timerType,
      Value<String>? description}) {
    return FavoriteWorkoutsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      workout: workout ?? this.workout,
      timerType: timerType ?? this.timerType,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (workout.present) {
      map['workout'] = Variable<String>(workout.value);
    }
    if (timerType.present) {
      map['timer_type'] = Variable<String>(timerType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteWorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('workout: $workout, ')
          ..write('timerType: $timerType, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $TrainingHistoryTable extends TrainingHistory
    with TableInfo<$TrainingHistoryTable, TrainingHistoryRawData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startAtMeta =
      const VerificationMeta('startAt');
  @override
  late final GeneratedColumn<int> startAt = GeneratedColumn<int>(
      'start_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<int> endAt = GeneratedColumn<int>(
      'end_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _wellBeingMeta =
      const VerificationMeta('wellBeing');
  @override
  late final GeneratedColumn<int> wellBeing = GeneratedColumn<int>(
      'well_being', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _workoutMeta =
      const VerificationMeta('workout');
  @override
  late final GeneratedColumn<String> workout = GeneratedColumn<String>(
      'workout', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timerTypeMeta =
      const VerificationMeta('timerType');
  @override
  late final GeneratedColumn<String> timerType = GeneratedColumn<String>(
      'timer_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intervalsMeta =
      const VerificationMeta('intervals');
  @override
  late final GeneratedColumn<String> intervals = GeneratedColumn<String>(
      'intervals', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        startAt,
        endAt,
        name,
        description,
        wellBeing,
        workout,
        timerType,
        intervals
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_history';
  @override
  VerificationContext validateIntegrity(
      Insertable<TrainingHistoryRawData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_at')) {
      context.handle(_startAtMeta,
          startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta));
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
          _endAtMeta, endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta));
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('well_being')) {
      context.handle(_wellBeingMeta,
          wellBeing.isAcceptableOrUnknown(data['well_being']!, _wellBeingMeta));
    }
    if (data.containsKey('workout')) {
      context.handle(_workoutMeta,
          workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta));
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('timer_type')) {
      context.handle(_timerTypeMeta,
          timerType.isAcceptableOrUnknown(data['timer_type']!, _timerTypeMeta));
    } else if (isInserting) {
      context.missing(_timerTypeMeta);
    }
    if (data.containsKey('intervals')) {
      context.handle(_intervalsMeta,
          intervals.isAcceptableOrUnknown(data['intervals']!, _intervalsMeta));
    } else if (isInserting) {
      context.missing(_intervalsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingHistoryRawData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingHistoryRawData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_at'])!,
      endAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_at'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      wellBeing: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}well_being']),
      workout: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workout'])!,
      timerType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timer_type'])!,
      intervals: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intervals'])!,
    );
  }

  @override
  $TrainingHistoryTable createAlias(String alias) {
    return $TrainingHistoryTable(attachedDatabase, alias);
  }
}

class TrainingHistoryRawData extends DataClass
    implements Insertable<TrainingHistoryRawData> {
  final int id;
  final int startAt;
  final int endAt;
  final String name;
  final String description;
  final int? wellBeing;
  final String workout;
  final String timerType;
  final String intervals;
  const TrainingHistoryRawData(
      {required this.id,
      required this.startAt,
      required this.endAt,
      required this.name,
      required this.description,
      this.wellBeing,
      required this.workout,
      required this.timerType,
      required this.intervals});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_at'] = Variable<int>(startAt);
    map['end_at'] = Variable<int>(endAt);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || wellBeing != null) {
      map['well_being'] = Variable<int>(wellBeing);
    }
    map['workout'] = Variable<String>(workout);
    map['timer_type'] = Variable<String>(timerType);
    map['intervals'] = Variable<String>(intervals);
    return map;
  }

  TrainingHistoryCompanion toCompanion(bool nullToAbsent) {
    return TrainingHistoryCompanion(
      id: Value(id),
      startAt: Value(startAt),
      endAt: Value(endAt),
      name: Value(name),
      description: Value(description),
      wellBeing: wellBeing == null && nullToAbsent
          ? const Value.absent()
          : Value(wellBeing),
      workout: Value(workout),
      timerType: Value(timerType),
      intervals: Value(intervals),
    );
  }

  factory TrainingHistoryRawData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingHistoryRawData(
      id: serializer.fromJson<int>(json['id']),
      startAt: serializer.fromJson<int>(json['startAt']),
      endAt: serializer.fromJson<int>(json['endAt']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      wellBeing: serializer.fromJson<int?>(json['wellBeing']),
      workout: serializer.fromJson<String>(json['workout']),
      timerType: serializer.fromJson<String>(json['timerType']),
      intervals: serializer.fromJson<String>(json['intervals']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startAt': serializer.toJson<int>(startAt),
      'endAt': serializer.toJson<int>(endAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'wellBeing': serializer.toJson<int?>(wellBeing),
      'workout': serializer.toJson<String>(workout),
      'timerType': serializer.toJson<String>(timerType),
      'intervals': serializer.toJson<String>(intervals),
    };
  }

  TrainingHistoryRawData copyWith(
          {int? id,
          int? startAt,
          int? endAt,
          String? name,
          String? description,
          Value<int?> wellBeing = const Value.absent(),
          String? workout,
          String? timerType,
          String? intervals}) =>
      TrainingHistoryRawData(
        id: id ?? this.id,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        name: name ?? this.name,
        description: description ?? this.description,
        wellBeing: wellBeing.present ? wellBeing.value : this.wellBeing,
        workout: workout ?? this.workout,
        timerType: timerType ?? this.timerType,
        intervals: intervals ?? this.intervals,
      );
  @override
  String toString() {
    return (StringBuffer('TrainingHistoryRawData(')
          ..write('id: $id, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('wellBeing: $wellBeing, ')
          ..write('workout: $workout, ')
          ..write('timerType: $timerType, ')
          ..write('intervals: $intervals')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startAt, endAt, name, description,
      wellBeing, workout, timerType, intervals);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingHistoryRawData &&
          other.id == this.id &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.wellBeing == this.wellBeing &&
          other.workout == this.workout &&
          other.timerType == this.timerType &&
          other.intervals == this.intervals);
}

class TrainingHistoryCompanion extends UpdateCompanion<TrainingHistoryRawData> {
  final Value<int> id;
  final Value<int> startAt;
  final Value<int> endAt;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> wellBeing;
  final Value<String> workout;
  final Value<String> timerType;
  final Value<String> intervals;
  const TrainingHistoryCompanion({
    this.id = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.wellBeing = const Value.absent(),
    this.workout = const Value.absent(),
    this.timerType = const Value.absent(),
    this.intervals = const Value.absent(),
  });
  TrainingHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int startAt,
    required int endAt,
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.wellBeing = const Value.absent(),
    required String workout,
    required String timerType,
    required String intervals,
  })  : startAt = Value(startAt),
        endAt = Value(endAt),
        workout = Value(workout),
        timerType = Value(timerType),
        intervals = Value(intervals);
  static Insertable<TrainingHistoryRawData> custom({
    Expression<int>? id,
    Expression<int>? startAt,
    Expression<int>? endAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? wellBeing,
    Expression<String>? workout,
    Expression<String>? timerType,
    Expression<String>? intervals,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (wellBeing != null) 'well_being': wellBeing,
      if (workout != null) 'workout': workout,
      if (timerType != null) 'timer_type': timerType,
      if (intervals != null) 'intervals': intervals,
    });
  }

  TrainingHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? startAt,
      Value<int>? endAt,
      Value<String>? name,
      Value<String>? description,
      Value<int?>? wellBeing,
      Value<String>? workout,
      Value<String>? timerType,
      Value<String>? intervals}) {
    return TrainingHistoryCompanion(
      id: id ?? this.id,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      name: name ?? this.name,
      description: description ?? this.description,
      wellBeing: wellBeing ?? this.wellBeing,
      workout: workout ?? this.workout,
      timerType: timerType ?? this.timerType,
      intervals: intervals ?? this.intervals,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<int>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<int>(endAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (wellBeing.present) {
      map['well_being'] = Variable<int>(wellBeing.value);
    }
    if (workout.present) {
      map['workout'] = Variable<String>(workout.value);
    }
    if (timerType.present) {
      map['timer_type'] = Variable<String>(timerType.value);
    }
    if (intervals.present) {
      map['intervals'] = Variable<String>(intervals.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingHistoryCompanion(')
          ..write('id: $id, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('wellBeing: $wellBeing, ')
          ..write('workout: $workout, ')
          ..write('timerType: $timerType, ')
          ..write('intervals: $intervals')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $FavoriteWorkoutsTable favoriteWorkouts =
      $FavoriteWorkoutsTable(this);
  late final $TrainingHistoryTable trainingHistory =
      $TrainingHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favoriteWorkouts, trainingHistory];
}
