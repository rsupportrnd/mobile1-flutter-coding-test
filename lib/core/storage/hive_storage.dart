import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  String boxName = "app_box";
  static final HiveStorage _instance = HiveStorage._();
  Box? _box;

  static HiveStorage get instance => _instance;

  HiveStorage._();

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  Future<void> put<T>(String key, T value, {String? boxName}) async {
    final box = _box ?? await Hive.openBox(boxName ?? this.boxName);
    await box.put(key, value);
  }

  Future<T?> get<T>(String key, {String? boxName}) async {
    final box = _box ?? await Hive.openBox(boxName ?? this.boxName);
    final value = box.get(key);

    if (value == null) return null;

    try {
      return value as T;
    } catch (e) {
      return null;
    }
  }

  Future<void> delete<T>(String key, {String? boxName}) async {
    final box = _box ?? await Hive.openBox(boxName ?? this.boxName);
    box.delete(key);
  }

  Future<void> deleteBox<T>({String? boxName}) async {
    await Hive.deleteBoxFromDisk(boxName ?? this.boxName);
  }

  Future<void> deleteFromDisk() async {
    await Hive.deleteFromDisk();
  }
}
