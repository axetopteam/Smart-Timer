//
//  Generated code. Do not modify.
//  source: work_rest.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class WorkRest extends $pb.GeneratedMessage {
  factory WorkRest({
    $core.int? roundsCount,
    $core.double? ratio,
    $core.int? restAfterSetInSeconds,
  }) {
    final $result = create();
    if (roundsCount != null) {
      $result.roundsCount = roundsCount;
    }
    if (ratio != null) {
      $result.ratio = ratio;
    }
    if (restAfterSetInSeconds != null) {
      $result.restAfterSetInSeconds = restAfterSetInSeconds;
    }
    return $result;
  }
  WorkRest._() : super();
  factory WorkRest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkRest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkRest', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'roundsCount', $pb.PbFieldType.OU3, protoName: 'roundsCount')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'ratio', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'restAfterSetInSeconds', $pb.PbFieldType.O3, protoName: 'restAfterSetInSeconds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkRest clone() => WorkRest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkRest copyWith(void Function(WorkRest) updates) => super.copyWith((message) => updates(message as WorkRest)) as WorkRest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkRest create() => WorkRest._();
  WorkRest createEmptyInstance() => create();
  static $pb.PbList<WorkRest> createRepeated() => $pb.PbList<WorkRest>();
  @$core.pragma('dart2js:noInline')
  static WorkRest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkRest>(create);
  static WorkRest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get roundsCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set roundsCount($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoundsCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoundsCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get ratio => $_getN(1);
  @$pb.TagNumber(2)
  set ratio($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRatio() => $_has(1);
  @$pb.TagNumber(2)
  void clearRatio() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get restAfterSetInSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set restAfterSetInSeconds($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRestAfterSetInSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearRestAfterSetInSeconds() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
