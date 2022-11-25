import 'package:flutter/cupertino.dart';
import 'package:rs_flutter_test/util/r_color.dart';

class MainViewModel with ChangeNotifier {
  bool _status1 = false;
  bool _status2 = false;
  bool _status3 = false;
  bool _status4 = false;
  bool _status5 = false;
  bool _status6 = false;
  bool _status7 = false;
  bool _status8 = false;
  bool _isSwitchOn = false;

  Color _textColor = RsupportColor.black_01;
  Color _appBarColor = RsupportColor.black_02;
  Color _bgColor = RsupportColor.white_01;

  bool get status1 => _status1;

  bool get status2 => _status2;

  bool get status3 => _status3;

  bool get status4 => _status4;

  bool get status5 => _status5;

  bool get status6 => _status6;

  bool get status7 => _status7;

  bool get status8 => _status8;

  bool get isSwitchOn => _isSwitchOn;

  Color get textColor => _textColor;

  Color get appBarColor => _appBarColor;

  Color get bgColor => _bgColor;

  String get activeIconUrl =>
      "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png";

  String get inActiveIconUrl =>
      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png";

  setStatus1(bool isChecked) {
    _status1 = isChecked;
    notifyListeners();
  }

  setStatus2(bool isChecked) {
    _status2 = isChecked;
    notifyListeners();
  }

  setStatus3(bool isChecked) {
    _status3 = isChecked;
    notifyListeners();
  }

  setStatus4(bool isChecked) {
    _status4 = isChecked;
    notifyListeners();
  }

  setStatus5(bool isChecked) {
    _status5 = isChecked;
    notifyListeners();
  }

  setStatus6(bool isChecked) {
    _status6 = isChecked;
    notifyListeners();
  }

  setStatus7(bool isChecked) {
    _status7 = isChecked;
    _changeThemeColor(isChecked);
    notifyListeners();
  }

  setStatus8(bool isChecked) {
    _status8 = isChecked;
    notifyListeners();
  }

  setSwitchOn(bool isChecked) {
    _isSwitchOn = isChecked;
    notifyListeners();
  }

  _changeThemeColor(bool isChecked) {
    _textColor = isChecked ? RsupportColor.dartThemeText : RsupportColor.lightThemeText;
    _appBarColor = isChecked ? RsupportColor.dartThemeAppBar : RsupportColor.lightThemeAppBar;
    _bgColor = isChecked ? RsupportColor.dartThemeBg : RsupportColor.lightThemeBg;
  }
}
