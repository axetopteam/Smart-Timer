//
//  Generated code. Do not modify.
//  source: work_rest_settings/work_rest_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../work_rest/work_rest.pb.dart' as $0;

class WorkRestSettings extends $pb.GeneratedMessage {
  factory WorkRestSettings({
    $core.Iterable<$0.WorkRest>? workRests,
  }) {
    final $result = create();
    if (workRests != null) {
      $result.workRests.addAll(workRests);
    }
    return $result;
  }
  WorkRestSettings._() : super();
  factory WorkRestSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkRestSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkRestSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..pc<$0.WorkRest>(1, _omitFieldNames ? '' : 'workRests', $pb.PbFieldType.PM, protoName: 'workRests', subBuilder: $0.WorkRest.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkRestSettings clone() => WorkRestSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkRestSettings copyWith(void Function(WorkRestSettings) updates) => super.copyWith((message) => updates(message as WorkRestSettings)) as WorkRestSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkRestSettings create() => WorkRestSettings._();
  WorkRestSettings createEmptyInstance() => create();
  static $pb.PbList<WorkRestSettings> createRepeated() => $pb.PbList<WorkRestSettings>();
  @$core.pragma('dart2js:noInline')
  static WorkRestSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkRestSettings>(create);
  static WorkRestSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.WorkRest> get workRests => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
