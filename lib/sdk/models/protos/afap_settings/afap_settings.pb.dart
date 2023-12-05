//
//  Generated code. Do not modify.
//  source: afap_settings/afap_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../afap/afap.pb.dart' as $0;

class AfapSettings extends $pb.GeneratedMessage {
  factory AfapSettings({
    $core.Iterable<$0.Afap>? afaps,
  }) {
    final $result = create();
    if (afaps != null) {
      $result.afaps.addAll(afaps);
    }
    return $result;
  }
  AfapSettings._() : super();
  factory AfapSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AfapSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AfapSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..pc<$0.Afap>(1, _omitFieldNames ? '' : 'afaps', $pb.PbFieldType.PM, subBuilder: $0.Afap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AfapSettings clone() => AfapSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AfapSettings copyWith(void Function(AfapSettings) updates) => super.copyWith((message) => updates(message as AfapSettings)) as AfapSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AfapSettings create() => AfapSettings._();
  AfapSettings createEmptyInstance() => create();
  static $pb.PbList<AfapSettings> createRepeated() => $pb.PbList<AfapSettings>();
  @$core.pragma('dart2js:noInline')
  static AfapSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AfapSettings>(create);
  static AfapSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.Afap> get afaps => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
