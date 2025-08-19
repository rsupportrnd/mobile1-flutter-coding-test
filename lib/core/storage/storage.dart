import 'package:hive_flutter/hive_flutter.dart';

class Storage {
  static const _boxName = 'app_storage';
  Box? _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.initFlutter();
      _box = await Hive.openBox(_boxName);
    } else {
      _box = Hive.box(_boxName);
    }
  }

  Box get _b {
    final b = _box;
    if (b == null || !b.isOpen) {
      throw StateError('Storage not initialized. Call storage.init().');
    }
    return b;
  }

  dynamic get(String key) {
    if (key == 'app:firstSeedDone') {
      return _b.get(key, defaultValue: false);
    }
    if (key == 'app:lastUserId') {
      return _b.get(key, defaultValue: '');
    }
    if (key.startsWith('roomMeta:')) {
      return _b.get(key) ?? <String, dynamic>{};
    }
    if (key.startsWith('read:')) {
      return _b.get(key) ?? <String, dynamic>{};
    }
    if (key.startsWith('msgs:')) {
      return _b.get(key) ?? <dynamic>[];
    }
    if (key.startsWith('user:')) {
      return _b.get(key) ?? <String, dynamic>{};
    }
    if (key.startsWith('room:')) {
      return _b.get(key) ?? <String, dynamic>{};
    }
    return _b.get(key);
  }

  Future<void> set<T>(String key, T value) => _b.put(key, value);
  Future<void> remove(String key) => _b.delete(key);
  Future<void> clear() => _b.clear();
  Iterable<dynamic> keys() => _b.keys;
  // stream 구독용
  Stream<BoxEvent> watch({String? key}) => _b.watch(key: key);
}
