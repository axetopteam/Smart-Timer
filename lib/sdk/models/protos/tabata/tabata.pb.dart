//
//  Generated code. Do not modify.
//  source: tabata.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Tabata extends $pb.GeneratedMessage {
  factory Tabata({
    $core.int? workTimeInSeconds,
    $core.int? restTimeInSeconds,
    $core.int? roundsCount,
    $core.int? restAfterSetInSeconds,
  }) {
    final $result = create();
    if (workTimeInSeconds != null) {
      $result.workTimeInSeconds = workTimeInSeconds;
    }
    if (restTimeInSeconds != null) {
      $result.restTimeInSeconds = restTimeInSeconds;
    }
    if (roundsCount != null) {
      $result.roundsCount = roundsCount;
    }
    if (restAfterSetInSeconds != null) {
      $result.restAfterSetInSeconds = restAfterSetInSeconds;
    }
    return $result;
  }
  Tabata._() : super();
  factory Tabata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tabata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Tabata', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'workTimeInSeconds', $pb.PbFieldType.OU3, protoName: 'workTimeInSeconds')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'restTimeInSeconds', $pb.PbFieldType.OU3, protoName: 'restTimeInSeconds')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'roundsCount', $pb.PbFieldType.OU3, protoName: 'roundsCount')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'restAfterSetInSeconds', $pb.PbFieldType.OU3, protoName: 'restAfterSetInSeconds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tabata clone() => Tabata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tabata copyWith(void Function(Tabata) updates) => super.copyWith((message) => updates(message as Tabata)) as Tabata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Tabata create() => Tabata._();
  Tabata createEmptyInstance() => create();
  static $pb.PbList<Tabata> createRepeated() => $pb.PbList<Tabata>();
  @$core.pragma('dart2js:noInline')
  static Tabata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tabata>(create);
  static Tabata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get workTimeInSeconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set workTimeInSeconds($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkTimeInSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkTimeInSeconds() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get restTimeInSeconds => $_getIZ(1);
  @$pb.TagNumber(2)
  set restTimeInSeconds($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRestTimeInSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearRestTimeInSeconds() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get roundsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set roundsCount($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoundsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoundsCount() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get restAfterSetInSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set restAfterSetInSeconds($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRestAfterSetInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearRestAfterSetInSeconds() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
