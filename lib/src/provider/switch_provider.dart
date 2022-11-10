import 'package:flutter/material.dart';
import 'package:rs_flutter_test/src/ui/home_widget.dart';

class SwitchProvider extends ChangeNotifier {
  final List<bool> _status = [
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Color _textColor = Colors.black;
  Color _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
  Color _scaffoldBgColor = Colors.white;

  bool getStatus(SwitchTypes switchType) => _status[getSwitchIndex(switchType)];

  Color get textColor => _textColor;
  Color get appBarColor => _appBarColor;
  Color get scaffoldBgColor => _scaffoldBgColor;

  int getSwitchIndex(value) {
    switch (value) {
      case SwitchTypes.appBarSwitch:
        return 0;
      case SwitchTypes.defaultSwitch:
        return 1;
      case SwitchTypes.customColorBorderSwitch:
        return 2;
      case SwitchTypes.customOnOffTextSwitch:
        return 3;
      case SwitchTypes.customSizeSwitch:
        return 4;
      case SwitchTypes.customBorderPaddingSwitch:
        return 5;
      case SwitchTypes.customtextSwitch:
        return 6;
      case SwitchTypes.iconToggleSwitch:
        return 7;
      case SwitchTypes.imageAsToggleSwitch:
        return 8;
      default:
        return 0;
    }
  }

  setValue(value, SwitchTypes switchType) {
    _status[getSwitchIndex(switchType)] = value;
    notifyListeners();
  }

  setThemeColor(value) {
    if (value) {
      _textColor = Colors.white;
      _appBarColor = const Color.fromRGBO(22, 27, 34, 1);
      _scaffoldBgColor = const Color(0xFF0D1117);
    } else {
      _textColor = Colors.black;
      _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
      _scaffoldBgColor = Colors.white;
    }
    notifyListeners();
  }
}
