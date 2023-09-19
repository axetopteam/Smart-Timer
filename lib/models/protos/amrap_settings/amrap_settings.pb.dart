//
//  Generated code. Do not modify.
//  source: amrap_settings/amrap_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../amrap/amrap.pb.dart' as $0;

class AmrapSettings extends $pb.GeneratedMessage {
  factory AmrapSettings({
    $core.Iterable<$0.Amrap>? amraps,
  }) {
    final $result = create();
    if (amraps != null) {
      $result.amraps.addAll(amraps);
    }
    return $result;
  }
  AmrapSettings._() : super();
  factory AmrapSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AmrapSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AmrapSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..pc<$0.Amrap>(1, _omitFieldNames ? '' : 'amraps', $pb.PbFieldType.PM, subBuilder: $0.Amrap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AmrapSettings clone() => AmrapSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AmrapSettings copyWith(void Function(AmrapSettings) updates) => super.copyWith((message) => updates(message as AmrapSettings)) as AmrapSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AmrapSettings create() => AmrapSettings._();
  AmrapSettings createEmptyInstance() => create();
  static $pb.PbList<AmrapSettings> createRepeated() => $pb.PbList<AmrapSettings>();
  @$core.pragma('dart2js:noInline')
  static AmrapSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AmrapSettings>(create);
  static AmrapSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.Amrap> get amraps => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
