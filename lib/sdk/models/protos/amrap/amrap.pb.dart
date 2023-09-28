//
//  Generated code. Do not modify.
//  source: amrap.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Amrap extends $pb.GeneratedMessage {
  factory Amrap({
    $core.int? workDurationInSeconds,
    $core.int? restDurationInSeconds,
  }) {
    final $result = create();
    if (workDurationInSeconds != null) {
      $result.workDurationInSeconds = workDurationInSeconds;
    }
    if (restDurationInSeconds != null) {
      $result.restDurationInSeconds = restDurationInSeconds;
    }
    return $result;
  }
  Amrap._() : super();
  factory Amrap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Amrap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Amrap', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'workDurationInSeconds', $pb.PbFieldType.OU3, protoName: 'workDurationInSeconds')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'restDurationInSeconds', $pb.PbFieldType.OU3, protoName: 'restDurationInSeconds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Amrap clone() => Amrap()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Amrap copyWith(void Function(Amrap) updates) => super.copyWith((message) => updates(message as Amrap)) as Amrap;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Amrap create() => Amrap._();
  Amrap createEmptyInstance() => create();
  static $pb.PbList<Amrap> createRepeated() => $pb.PbList<Amrap>();
  @$core.pragma('dart2js:noInline')
  static Amrap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Amrap>(create);
  static Amrap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get workDurationInSeconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set workDurationInSeconds($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkDurationInSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkDurationInSeconds() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get restDurationInSeconds => $_getIZ(1);
  @$pb.TagNumber(2)
  set restDurationInSeconds($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRestDurationInSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearRestDurationInSeconds() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
