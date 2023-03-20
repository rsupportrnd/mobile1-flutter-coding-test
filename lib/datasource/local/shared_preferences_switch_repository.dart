import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/switch_status.dart';
import '../../domain/repository/switch_repository.dart';

class SharedPreferencesSwitchRepository implements SwitchRepository {
  static const String prefix = 'switch_status_v1_';

  @override
  Future<SwitchStatus> getStatus(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('$prefix$key') ?? false;
    return SwitchStatus(key: key, value: value);
  }

  @override
  Future<bool> saveStatus(SwitchStatus switchStatus) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        '$prefix${switchStatus.key}', switchStatus.value);
  }
}
