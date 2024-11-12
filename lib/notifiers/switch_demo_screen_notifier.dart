import 'package:flutter/material.dart';
import 'package:rs_flutter_test/models/enums/section_switch_type.dart';

class SwitchDemoScreenNotifier extends ChangeNotifier {
  final Map<SectionSwitchType, bool> _map = {
    SectionSwitchType.colorsAndBorders: true,
  };

  bool _isSwitchOn = false;
  bool get isSwitchOn => _isSwitchOn;
  set isSwitchOn(bool value) {
    _isSwitchOn = value;
    notifyListeners();
  }

  bool isCheckedType(SectionSwitchType type) {
    return _map.containsKey(type) ? _map[type]! : false;
  }

  void toggleSwitchType(SectionSwitchType type) {
    if (isCheckedType(type)) {
      _map[type] = false;
    } else {
      _map[type] = true;
    }
    notifyListeners();
  }
}
