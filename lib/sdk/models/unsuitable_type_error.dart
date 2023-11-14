class UnsuitableTypeError extends Error {
  UnsuitableTypeError(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}
