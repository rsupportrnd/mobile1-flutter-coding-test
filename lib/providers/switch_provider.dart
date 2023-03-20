import 'package:flutter/material.dart';

import '../domain/entities/switch_status.dart';
import '../domain/repository/switch_repository.dart';
import '../domain/usecase/switch_usecase.dart';

class SwitchProvider with ChangeNotifier {
  final SwitchUsecase _switchUsecase;
  final Map<String, SwitchStatus> _switches = {};

  SwitchProvider({
    required SwitchRepository switchRepository,
    required List<String> keys,
  }) : _switchUsecase = SwitchUsecase(switchRepository) {
    loadSwitchStatuses(keys);
  }

  Future<void> loadSwitchStatuses(List<String> keys) async {
    final map = await _switchUsecase.fetchSwitchStatuses(keys);
    _switches.addAll(map);
    notifyListeners();
  }

  bool isActive(String key) {
    return _switches[key]?.value ?? false;
  }

  void toggleSwitch(String key) async {
    final status = _switches[key];
    status?.value = !status.value;
    await _switchUsecase
        .saveStatus(_switches[key] ?? SwitchStatus(key: key, value: true));
    notifyListeners();
  }
}
