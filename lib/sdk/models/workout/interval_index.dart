class IntervalIndex {
  String? name;
  final int index;
  final int? totalCount;

  IntervalIndex({
    this.name,
    required this.index,
    this.totalCount,
  });

  IntervalIndex copyWith(int? index) {
    return IntervalIndex(index: index ?? this.index, name: name, totalCount: totalCount);
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    if (name != null) {
      buffer.writeAll([name, ' ']);
    }
    buffer.write(index);
    if (totalCount != null) {
      buffer.writeAll(['/', totalCount]);
    }
    return buffer.toString();
  }
}
