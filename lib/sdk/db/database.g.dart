// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WorkoutsHistoryTable extends WorkoutsHistory
    with TableInfo<$WorkoutsHistoryTable, WorkoutSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutMeta =
      const VerificationMeta('workout');
  @override
  late final GeneratedColumn<String> workout = GeneratedColumn<String>(
      'workout', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<int> endAt = GeneratedColumn<int>(
      'end_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, workout, endAt, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts_history';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout')) {
      context.handle(_workoutMeta,
          workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta));
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
          _endAtMeta, endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta));
    } else if (isInserting) {
      context.missing(_endAtMeta);
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
  WorkoutSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSettings(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workout: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workout'])!,
      endAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_at'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $WorkoutsHistoryTable createAlias(String alias) {
    return $WorkoutsHistoryTable(attachedDatabase, alias);
  }
}

class WorkoutSettings extends DataClass implements Insertable<WorkoutSettings> {
  final int id;
  final String workout;
  final int endAt;
  final String description;
  const WorkoutSettings(
      {required this.id,
      required this.workout,
      required this.endAt,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout'] = Variable<String>(workout);
    map['end_at'] = Variable<int>(endAt);
    map['description'] = Variable<String>(description);
    return map;
  }

  WorkoutsHistoryCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsHistoryCompanion(
      id: Value(id),
      workout: Value(workout),
      endAt: Value(endAt),
      description: Value(description),
    );
  }

  factory WorkoutSettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSettings(
      id: serializer.fromJson<int>(json['id']),
      workout: serializer.fromJson<String>(json['workout']),
      endAt: serializer.fromJson<int>(json['endAt']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workout': serializer.toJson<String>(workout),
      'endAt': serializer.toJson<int>(endAt),
      'description': serializer.toJson<String>(description),
    };
  }

  WorkoutSettings copyWith(
          {int? id, String? workout, int? endAt, String? description}) =>
      WorkoutSettings(
        id: id ?? this.id,
        workout: workout ?? this.workout,
        endAt: endAt ?? this.endAt,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('WorkoutSettings(')
          ..write('id: $id, ')
          ..write('workout: $workout, ')
          ..write('endAt: $endAt, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workout, endAt, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSettings &&
          other.id == this.id &&
          other.workout == this.workout &&
          other.endAt == this.endAt &&
          other.description == this.description);
}

class WorkoutsHistoryCompanion extends UpdateCompanion<WorkoutSettings> {
  final Value<int> id;
  final Value<String> workout;
  final Value<int> endAt;
  final Value<String> description;
  const WorkoutsHistoryCompanion({
    this.id = const Value.absent(),
    this.workout = const Value.absent(),
    this.endAt = const Value.absent(),
    this.description = const Value.absent(),
  });
  WorkoutsHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String workout,
    required int endAt,
    this.description = const Value.absent(),
  })  : workout = Value(workout),
        endAt = Value(endAt);
  static Insertable<WorkoutSettings> custom({
    Expression<int>? id,
    Expression<String>? workout,
    Expression<int>? endAt,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workout != null) 'workout': workout,
      if (endAt != null) 'end_at': endAt,
      if (description != null) 'description': description,
    });
  }

  WorkoutsHistoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? workout,
      Value<int>? endAt,
      Value<String>? description}) {
    return WorkoutsHistoryCompanion(
      id: id ?? this.id,
      workout: workout ?? this.workout,
      endAt: endAt ?? this.endAt,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workout.present) {
      map['workout'] = Variable<String>(workout.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<int>(endAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsHistoryCompanion(')
          ..write('id: $id, ')
          ..write('workout: $workout, ')
          ..write('endAt: $endAt, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $WorkoutsHistoryTable workoutsHistory =
      $WorkoutsHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [workoutsHistory];
}
