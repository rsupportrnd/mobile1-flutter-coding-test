import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  String boxName = "app_box";
  static final HiveStorage _instance = HiveStorage._();

  static HiveStorage get instance => _instance;

  HiveStorage._();

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<void> put<T>(String key, T value, {String? boxName}) async {
    final box = await Hive.openBox<T>(boxName ?? this.boxName);
    await box.put(key, value);
  }

  Future<T?> get<T>(String key, {String? boxName}) async {
    final box = await Hive.openBox<T>(boxName ?? this.boxName);
    return box.get(key);
  }

  Future<void> delete<T>(String key, {String? boxName}) async {
    final box = await Hive.openBox<T>(boxName ?? this.boxName);
    box.delete(key);
  }

  Future<void> deleteBox<T>({String? boxName}) async {
    await Hive.deleteBoxFromDisk(boxName ?? this.boxName);
  }

  Future<void> deleteFromDisk() async {
    await Hive.deleteFromDisk();
  }
}
