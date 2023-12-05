import 'package:easy_localization/easy_localization.dart';

import '../unsuitable_type_error.dart';

class IntervalIndex {
  String? localeKey;
  final int index;
  final int? totalCount;

  IntervalIndex({
    this.localeKey,
    required this.index,
    this.totalCount,
  });

  IntervalIndex copyWith(int? index) {
    return IntervalIndex(index: index ?? this.index, localeKey: localeKey, totalCount: totalCount);
  }

  Map<String, dynamic> toJson() {
    return {
      if (localeKey != null) 'localeKey': localeKey,
      'index': index,
      if (totalCount != null) 'totalCount': totalCount,
    };
  }

  factory IntervalIndex.fromJson(Map<String, dynamic> json) {
    final localeKey = json['localeKey'];
    final index = json['index'] ?? (throw UnsuitableTypeError('index is null'));
    final totalCount = json['totalCount'];
    return IntervalIndex(
      localeKey: localeKey,
      index: index,
      totalCount: totalCount,
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    if (localeKey != null) {
      buffer.writeAll([localeKey!.tr().toUpperCase(), ' ']);
    }
    buffer.write(index + 1);
    if (totalCount != null) {
      buffer.writeAll(['/', totalCount]);
    }
    return buffer.toString();
  }
}
