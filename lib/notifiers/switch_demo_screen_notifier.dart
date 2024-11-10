import 'package:flutter/material.dart';

class SwitchDemoScreenNotifier extends ChangeNotifier {
  bool _isSwitchOn = false;
  bool get isSwitchOn => _isSwitchOn;
  set isSwitchOn(bool value) {
    _isSwitchOn = value;
    notifyListeners();
  }

  bool _status1 = false;
  bool get status1 => _status1;
  set status1(bool value) {
    _status1 = value;
    notifyListeners();
  }

  bool _status2 = true;
  bool get status2 => _status2;
  set status2(bool value) {
    _status2 = value;
    notifyListeners();
  }

  bool _status3 = false;
  bool get status3 => _status3;
  set status3(bool value) {
    _status3 = value;
    notifyListeners();
  }

  bool _status4 = false;
  bool get status4 => _status4;
  set status4(bool value) {
    _status4 = value;
    notifyListeners();
  }

  bool _status5 = false;
  bool get status5 => _status5;
  set status5(bool value) {
    _status5 = value;
    notifyListeners();
  }

  bool _status6 = false;
  bool get status6 => _status6;
  set status6(bool value) {
    _status6 = value;
    notifyListeners();
  }

  bool _status7 = false;
  bool get status7 => _status7;
  set status7(bool value) {
    _status7 = value;
    notifyListeners();
  }

  bool _status8 = false;
  bool get status8 => _status8;
  set status8(bool value) {
    _status8 = value;
    notifyListeners();
  }
}
