import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/models/enums/switch_type.dart';

class TypedFlutterSwitch extends StatelessWidget {
  const TypedFlutterSwitch({
    super.key,
    required this.type,
    required this.value,
    required this.onToggle,
  });

  final SwitchType type;
  final bool value;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SwitchType.normal:
        // TODO: Handle this case.
        break;
      case SwitchType.colorsAndBorders:
        return FlutterSwitch(
          width: 100.0,
          height: 55.0,
          toggleSize: 45.0,
          borderRadius: 30.0,
          padding: 2.0,
          toggleColor: const Color.fromRGBO(225, 225, 225, 1),
          switchBorder: Border.all(
            color: const Color.fromRGBO(2, 107, 206, 1),
            width: 6.0,
          ),
          toggleBorder: Border.all(
            color: const Color.fromRGBO(2, 107, 206, 1),
            width: 5.0,
          ),
          activeColor: const Color.fromRGBO(51, 226, 255, 1),
          inactiveColor: Colors.black38,
          value: value,
          onToggle: onToggle,
        );
      case SwitchType.onAndOff:
        return FlutterSwitch(
          showOnOff: true,
          activeTextColor: Colors.black,
          inactiveTextColor: Colors.blue[50]!,
          value: value,
          onToggle: onToggle,
        );
      case SwitchType.customSize:
        return FlutterSwitch(
          width: 55.0,
          height: 25.0,
          valueFontSize: 12.0,
          toggleSize: 18.0,
          value: value,
          onToggle: onToggle,
        );
      case SwitchType.borderRadiusAndPadding:
        return FlutterSwitch(
          width: 125.0,
          height: 55.0,
          valueFontSize: 25.0,
          toggleSize: 45.0,
          borderRadius: 30.0,
          padding: 8.0,
          showOnOff: true,
          value: value,
          onToggle: onToggle,
        );
      case SwitchType.customText:
        return FlutterSwitch(
          activeText: 'All Good. Negative.',
          inactiveText: 'Under Quarantine.',
          valueFontSize: 10.0,
          width: 110,
          borderRadius: 30.0,
          showOnOff: true,
          value: value,
          onToggle: onToggle,
        );
      case SwitchType.iconInToggle:
        return FlutterSwitch(
          width: 100.0,
          height: 55.0,
          toggleSize: 45.0,
          borderRadius: 30.0,
          padding: 2.0,
          activeToggleColor: const Color(0xFF0082C8),
          inactiveToggleColor: const Color(0xFF01579B),
          activeSwitchBorder: Border.all(
            color: const Color(0xFF00D2B8),
            width: 6.0,
          ),
          inactiveSwitchBorder: Border.all(
            color: const Color(0xFF29B6F6),
            width: 6.0,
          ),
          activeColor: const Color(0xFF55DDCA),
          inactiveColor: const Color(0xFF54C5F8),
          activeIcon: Image.network(
            'https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png',
          ),
          inactiveIcon: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png',
          ),
          value: value,
          onToggle: onToggle,
        );
      case SwitchType.imageAsToggleIcon:
        // TODO: Handle this case.
        break;
    }
    return FlutterSwitch(
      value: value,
      onToggle: onToggle,
    );
  }
}
