//
//  Generated code. Do not modify.
//  source: tabata_settings/tabata_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../tabata/tabata.pb.dart' as $0;

class TabataSettings extends $pb.GeneratedMessage {
  factory TabataSettings({
    $core.Iterable<$0.Tabata>? tabats,
  }) {
    final $result = create();
    if (tabats != null) {
      $result.tabats.addAll(tabats);
    }
    return $result;
  }
  TabataSettings._() : super();
  factory TabataSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TabataSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TabataSettings', package: const $pb.PackageName(_omitMessageNames ? '' : 'timer'), createEmptyInstance: create)
    ..pc<$0.Tabata>(1, _omitFieldNames ? '' : 'tabats', $pb.PbFieldType.PM, subBuilder: $0.Tabata.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TabataSettings clone() => TabataSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TabataSettings copyWith(void Function(TabataSettings) updates) => super.copyWith((message) => updates(message as TabataSettings)) as TabataSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TabataSettings create() => TabataSettings._();
  TabataSettings createEmptyInstance() => create();
  static $pb.PbList<TabataSettings> createRepeated() => $pb.PbList<TabataSettings>();
  @$core.pragma('dart2js:noInline')
  static TabataSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TabataSettings>(create);
  static TabataSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.Tabata> get tabats => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
