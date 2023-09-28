//
//  Generated code. Do not modify.
//  source: afap.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Afap extends $pb.GeneratedMessage {
  factory Afap({
    $core.int? timeCapInSeconds,
    $core.int? restTimeInSeconds,
    $core.bool? noTimeCap,
  }) {
    final $result = create();
    if (timeCapInSeconds != null) {
      $result.timeCapInSeconds = timeCapInSeconds;
    }
    if (restTimeInSeconds != null) {
      $result.restTimeInSeconds = restTimeInSeconds;
    }
    if (noTimeCap != null) {
      $result.noTimeCap = noTimeCap;
    }
    return $result;
  }
  Afap._() : super();
  factory Afap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Afap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Afap', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'timeCapInSeconds', $pb.PbFieldType.OU3, protoName: 'timeCapInSeconds')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'restTimeInSeconds', $pb.PbFieldType.OU3, protoName: 'restTimeInSeconds')
    ..aOB(3, _omitFieldNames ? '' : 'noTimeCap', protoName: 'noTimeCap')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Afap clone() => Afap()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Afap copyWith(void Function(Afap) updates) => super.copyWith((message) => updates(message as Afap)) as Afap;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Afap create() => Afap._();
  Afap createEmptyInstance() => create();
  static $pb.PbList<Afap> createRepeated() => $pb.PbList<Afap>();
  @$core.pragma('dart2js:noInline')
  static Afap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Afap>(create);
  static Afap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get timeCapInSeconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set timeCapInSeconds($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimeCapInSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeCapInSeconds() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get restTimeInSeconds => $_getIZ(1);
  @$pb.TagNumber(2)
  set restTimeInSeconds($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRestTimeInSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearRestTimeInSeconds() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get noTimeCap => $_getBF(2);
  @$pb.TagNumber(3)
  set noTimeCap($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNoTimeCap() => $_has(2);
  @$pb.TagNumber(3)
  void clearNoTimeCap() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
