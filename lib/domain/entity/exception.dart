class JsonLoadException implements Exception {
  final String message;
  const JsonLoadException(this.message);
  @override
  String toString() => 'JsonLoadException: $message';
}
