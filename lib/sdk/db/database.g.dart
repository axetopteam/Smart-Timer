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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $FavoriteWorkoutsTable favoriteWorkouts =
      $FavoriteWorkoutsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteWorkouts];
}
