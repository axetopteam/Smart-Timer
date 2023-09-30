//
//  Generated code. Do not modify.
//  source: workout_settings/workout_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../afap_settings/afap_settings.pb.dart' as $1;
import '../amrap_settings/amrap_settings.pb.dart' as $0;
import '../emom_settings/emom_settings.pb.dart' as $2;
import '../tabata_settings/tabata_settings.pb.dart' as $3;
import '../work_rest_settings/work_rest_settings.pb.dart' as $4;

enum WorkoutSettings_Workout {
  amrap, 
  afap, 
  emom, 
  tabata, 
  workRest, 
  notSet
}

class WorkoutSettings extends $pb.GeneratedMessage {
  factory WorkoutSettings({
    $0.AmrapSettings? amrap,
    $1.AfapSettings? afap,
    $2.EmomSettings? emom,
    $3.TabataSettings? tabata,
    $4.WorkRestSettings? workRest,
  }) {
    final $result = create();
    if (amrap != null) {
      $result.amrap = amrap;
    }
    if (afap != null) {
      $result.afap = afap;
    }
    if (emom != null) {
      $result.emom = emom;
    }
    if (tabata != null) {
      $result.tabata = tabata;
    }
    if (workRest != null) {
      $result.workRest = workRest;
    }
    return $result;
  }
  WorkoutSettings._() : super();
  factory WorkoutSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkoutSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, WorkoutSettings_Workout> _WorkoutSettings_WorkoutByTag = {
    1 : WorkoutSettings_Workout.amrap,
    2 : WorkoutSettings_Workout.afap,
    3 : WorkoutSettings_Workout.emom,
    4 : WorkoutSettings_Workout.tabata,
    5 : WorkoutSettings_Workout.workRest,
    0 : WorkoutSettings_Workout.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkoutSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOM<$0.AmrapSettings>(1, _omitFieldNames ? '' : 'amrap', subBuilder: $0.AmrapSettings.create)
    ..aOM<$1.AfapSettings>(2, _omitFieldNames ? '' : 'afap', subBuilder: $1.AfapSettings.create)
    ..aOM<$2.EmomSettings>(3, _omitFieldNames ? '' : 'emom', subBuilder: $2.EmomSettings.create)
    ..aOM<$3.TabataSettings>(4, _omitFieldNames ? '' : 'tabata', subBuilder: $3.TabataSettings.create)
    ..aOM<$4.WorkRestSettings>(5, _omitFieldNames ? '' : 'workRest', protoName: 'workRest', subBuilder: $4.WorkRestSettings.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkoutSettings clone() => WorkoutSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkoutSettings copyWith(void Function(WorkoutSettings) updates) => super.copyWith((message) => updates(message as WorkoutSettings)) as WorkoutSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkoutSettings create() => WorkoutSettings._();
  WorkoutSettings createEmptyInstance() => create();
  static $pb.PbList<WorkoutSettings> createRepeated() => $pb.PbList<WorkoutSettings>();
  @$core.pragma('dart2js:noInline')
  static WorkoutSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkoutSettings>(create);
  static WorkoutSettings? _defaultInstance;

  WorkoutSettings_Workout whichWorkout() => _WorkoutSettings_WorkoutByTag[$_whichOneof(0)]!;
  void clearWorkout() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.AmrapSettings get amrap => $_getN(0);
  @$pb.TagNumber(1)
  set amrap($0.AmrapSettings v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmrap() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmrap() => clearField(1);
  @$pb.TagNumber(1)
  $0.AmrapSettings ensureAmrap() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.AfapSettings get afap => $_getN(1);
  @$pb.TagNumber(2)
  set afap($1.AfapSettings v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAfap() => $_has(1);
  @$pb.TagNumber(2)
  void clearAfap() => clearField(2);
  @$pb.TagNumber(2)
  $1.AfapSettings ensureAfap() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.EmomSettings get emom => $_getN(2);
  @$pb.TagNumber(3)
  set emom($2.EmomSettings v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmom() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmom() => clearField(3);
  @$pb.TagNumber(3)
  $2.EmomSettings ensureEmom() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.TabataSettings get tabata => $_getN(3);
  @$pb.TagNumber(4)
  set tabata($3.TabataSettings v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTabata() => $_has(3);
  @$pb.TagNumber(4)
  void clearTabata() => clearField(4);
  @$pb.TagNumber(4)
  $3.TabataSettings ensureTabata() => $_ensure(3);

  @$pb.TagNumber(5)
  $4.WorkRestSettings get workRest => $_getN(4);
  @$pb.TagNumber(5)
  set workRest($4.WorkRestSettings v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasWorkRest() => $_has(4);
  @$pb.TagNumber(5)
  void clearWorkRest() => clearField(5);
  @$pb.TagNumber(5)
  $4.WorkRestSettings ensureWorkRest() => $_ensure(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
