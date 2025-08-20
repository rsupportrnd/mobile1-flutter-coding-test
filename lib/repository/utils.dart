import 'dart:convert';

Map<String, dynamic> toStringKeyMap(Object? raw) {
  if (raw is Map) {
    return raw.map((k, v) => MapEntry(k.toString(), v));
  }
  throw StateError('Expected Map-like for fromJson, got: ${raw.runtimeType}');
}

List<Map<String, dynamic>> toListOfStringKeyMap(Object? raw) {
  if (raw is List) {
    return raw
        .whereType<Map>() // Map만
        .map((m) => m.map((k, v) => MapEntry(k.toString(), v)))
        .toList();
  }
  throw StateError(
    'Expected List of Map for fromJson, got: ${raw.runtimeType}',
  );
}

dynamic normalizeJson(dynamic v) {
  if (v is Map) {
    return v.map((k, val) => MapEntry(k.toString(), normalizeJson(val)));
  } else if (v is List) {
    return v.map(normalizeJson).toList();
  }
  return v;
}
