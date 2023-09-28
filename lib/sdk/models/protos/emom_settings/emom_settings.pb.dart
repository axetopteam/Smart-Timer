//
//  Generated code. Do not modify.
//  source: emom_settings/emom_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../emom/emom.pb.dart' as $0;

class EmomSettings extends $pb.GeneratedMessage {
  factory EmomSettings({
    $core.Iterable<$0.Emom>? emoms,
  }) {
    final $result = create();
    if (emoms != null) {
      $result.emoms.addAll(emoms);
    }
    return $result;
  }
  EmomSettings._() : super();
  factory EmomSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmomSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmomSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..pc<$0.Emom>(1, _omitFieldNames ? '' : 'emoms', $pb.PbFieldType.PM, subBuilder: $0.Emom.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmomSettings clone() => EmomSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmomSettings copyWith(void Function(EmomSettings) updates) => super.copyWith((message) => updates(message as EmomSettings)) as EmomSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmomSettings create() => EmomSettings._();
  EmomSettings createEmptyInstance() => create();
  static $pb.PbList<EmomSettings> createRepeated() => $pb.PbList<EmomSettings>();
  @$core.pragma('dart2js:noInline')
  static EmomSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmomSettings>(create);
  static EmomSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.Emom> get emoms => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
