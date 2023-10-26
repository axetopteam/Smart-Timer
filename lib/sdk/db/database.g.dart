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
  static const VerificationMeta _finishAtMeta =
      const VerificationMeta('finishAt');
  @override
  late final GeneratedColumn<int> finishAt = GeneratedColumn<int>(
      'finish_at', aliasedName, false,
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
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
      'result', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_finished" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        finishAt,
        name,
        description,
        wellBeing,
        workout,
        timerType,
        result,
        isFinished
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
    if (data.containsKey('finish_at')) {
      context.handle(_finishAtMeta,
          finishAt.isAcceptableOrUnknown(data['finish_at']!, _finishAtMeta));
    } else if (isInserting) {
      context.missing(_finishAtMeta);
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
    if (data.containsKey('result')) {
      context.handle(_resultMeta,
          result.isAcceptableOrUnknown(data['result']!, _resultMeta));
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    } else if (isInserting) {
      context.missing(_isFinishedMeta);
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
      finishAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}finish_at'])!,
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
      result: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
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
  final int finishAt;
  final String name;
  final String description;
  final int? wellBeing;
  final String workout;
  final String timerType;
  final String result;
  final bool isFinished;
  const TrainingHistoryRawData(
      {required this.id,
      required this.finishAt,
      required this.name,
      required this.description,
      this.wellBeing,
      required this.workout,
      required this.timerType,
      required this.result,
      required this.isFinished});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['finish_at'] = Variable<int>(finishAt);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || wellBeing != null) {
      map['well_being'] = Variable<int>(wellBeing);
    }
    map['workout'] = Variable<String>(workout);
    map['timer_type'] = Variable<String>(timerType);
    map['result'] = Variable<String>(result);
    map['is_finished'] = Variable<bool>(isFinished);
    return map;
  }

  TrainingHistoryCompanion toCompanion(bool nullToAbsent) {
    return TrainingHistoryCompanion(
      id: Value(id),
      finishAt: Value(finishAt),
      name: Value(name),
      description: Value(description),
      wellBeing: wellBeing == null && nullToAbsent
          ? const Value.absent()
          : Value(wellBeing),
      workout: Value(workout),
      timerType: Value(timerType),
      result: Value(result),
      isFinished: Value(isFinished),
    );
  }

  factory TrainingHistoryRawData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingHistoryRawData(
      id: serializer.fromJson<int>(json['id']),
      finishAt: serializer.fromJson<int>(json['finishAt']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      wellBeing: serializer.fromJson<int?>(json['wellBeing']),
      workout: serializer.fromJson<String>(json['workout']),
      timerType: serializer.fromJson<String>(json['timerType']),
      result: serializer.fromJson<String>(json['result']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'finishAt': serializer.toJson<int>(finishAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'wellBeing': serializer.toJson<int?>(wellBeing),
      'workout': serializer.toJson<String>(workout),
      'timerType': serializer.toJson<String>(timerType),
      'result': serializer.toJson<String>(result),
      'isFinished': serializer.toJson<bool>(isFinished),
    };
  }

  TrainingHistoryRawData copyWith(
          {int? id,
          int? finishAt,
          String? name,
          String? description,
          Value<int?> wellBeing = const Value.absent(),
          String? workout,
          String? timerType,
          String? result,
          bool? isFinished}) =>
      TrainingHistoryRawData(
        id: id ?? this.id,
        finishAt: finishAt ?? this.finishAt,
        name: name ?? this.name,
        description: description ?? this.description,
        wellBeing: wellBeing.present ? wellBeing.value : this.wellBeing,
        workout: workout ?? this.workout,
        timerType: timerType ?? this.timerType,
        result: result ?? this.result,
        isFinished: isFinished ?? this.isFinished,
      );
  @override
  String toString() {
    return (StringBuffer('TrainingHistoryRawData(')
          ..write('id: $id, ')
          ..write('finishAt: $finishAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('wellBeing: $wellBeing, ')
          ..write('workout: $workout, ')
          ..write('timerType: $timerType, ')
          ..write('result: $result, ')
          ..write('isFinished: $isFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, finishAt, name, description, wellBeing,
      workout, timerType, result, isFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingHistoryRawData &&
          other.id == this.id &&
          other.finishAt == this.finishAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.wellBeing == this.wellBeing &&
          other.workout == this.workout &&
          other.timerType == this.timerType &&
          other.result == this.result &&
          other.isFinished == this.isFinished);
}

class TrainingHistoryCompanion extends UpdateCompanion<TrainingHistoryRawData> {
  final Value<int> id;
  final Value<int> finishAt;
  final Value<String> name;
  final Value<String> description;
  final Value<int?> wellBeing;
  final Value<String> workout;
  final Value<String> timerType;
  final Value<String> result;
  final Value<bool> isFinished;
  const TrainingHistoryCompanion({
    this.id = const Value.absent(),
    this.finishAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.wellBeing = const Value.absent(),
    this.workout = const Value.absent(),
    this.timerType = const Value.absent(),
    this.result = const Value.absent(),
    this.isFinished = const Value.absent(),
  });
  TrainingHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int finishAt,
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.wellBeing = const Value.absent(),
    required String workout,
    required String timerType,
    required String result,
    required bool isFinished,
  })  : finishAt = Value(finishAt),
        workout = Value(workout),
        timerType = Value(timerType),
        result = Value(result),
        isFinished = Value(isFinished);
  static Insertable<TrainingHistoryRawData> custom({
    Expression<int>? id,
    Expression<int>? finishAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? wellBeing,
    Expression<String>? workout,
    Expression<String>? timerType,
    Expression<String>? result,
    Expression<bool>? isFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (finishAt != null) 'finish_at': finishAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (wellBeing != null) 'well_being': wellBeing,
      if (workout != null) 'workout': workout,
      if (timerType != null) 'timer_type': timerType,
      if (result != null) 'result': result,
      if (isFinished != null) 'is_finished': isFinished,
    });
  }

  TrainingHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? finishAt,
      Value<String>? name,
      Value<String>? description,
      Value<int?>? wellBeing,
      Value<String>? workout,
      Value<String>? timerType,
      Value<String>? result,
      Value<bool>? isFinished}) {
    return TrainingHistoryCompanion(
      id: id ?? this.id,
      finishAt: finishAt ?? this.finishAt,
      name: name ?? this.name,
      description: description ?? this.description,
      wellBeing: wellBeing ?? this.wellBeing,
      workout: workout ?? this.workout,
      timerType: timerType ?? this.timerType,
      result: result ?? this.result,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (finishAt.present) {
      map['finish_at'] = Variable<int>(finishAt.value);
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
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingHistoryCompanion(')
          ..write('id: $id, ')
          ..write('finishAt: $finishAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('wellBeing: $wellBeing, ')
          ..write('workout: $workout, ')
          ..write('timerType: $timerType, ')
          ..write('result: $result, ')
          ..write('isFinished: $isFinished')
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
