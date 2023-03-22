import 'package:flutter/material.dart';

/// HomeView의 ViewModel.
class HomeViewModel extends ChangeNotifier {
  bool _status1 = false;
  bool get status1 => _status1;

  bool _status2 = true;
  bool get status2 => _status2;

  bool _status3 = false;
  bool get status3 => _status3;

  bool _status4 = false;
  bool get status4 => _status4;

  bool _status5 = false;
  bool get status5 => _status5;

  bool _status6 = false;
  bool get status6 => _status6;

  bool _status7 = false;
  bool get status7 => _status7;

  bool _status8 = false;
  bool get status8 => _status8;

  bool _isSwitchOn = false;
  bool get isSwitchOn => _isSwitchOn;

  void toggleStatus1(bool value) {
    _status1 = value;
    notifyListeners();
  }

  void toggleStatus2(bool value) {
    _status2 = value;
    notifyListeners();
  }

  void toggleStatus3(bool value) {
    _status3 = value;
    notifyListeners();
  }

  void toggleStatus4(bool value) {
    _status4 = value;
    notifyListeners();
  }

  void toggleStatus5(bool value) {
    _status5 = value;
    notifyListeners();
  }

  void toggleStatus6(bool value) {
    _status6 = value;
    notifyListeners();
  }

  void toggleStatus7(bool value) {
    _status7 = value;
    notifyListeners();
  }

  void toggleStatus8(bool value) {
    _status8 = value;
    notifyListeners();
  }

  void toggleSwitch(bool value) {
    _isSwitchOn = value;
    notifyListeners();
  }
}
