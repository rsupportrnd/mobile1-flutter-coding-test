import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  final bool showOnOff;
  final String? activeText;
  final String? inactiveText;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final FontWeight? activeTextFontWeight;
  final FontWeight? inactiveTextFontWeight;
  final Color toggleColor;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final double width;
  final double height;
  final double toggleSize;
  final double valueFontSize;
  final double borderRadius;
  final double padding;
  final BoxBorder? switchBorder;
  final BoxBorder? activeSwitchBorder;
  final BoxBorder? inactiveSwitchBorder;
  final BoxBorder? toggleBorder;
  final BoxBorder? activeToggleBorder;
  final BoxBorder? inactiveToggleBorder;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final Duration duration;
  final bool disabled;

  factory CustomSwitch.defaultSwitch({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
      value: value,
      onToggle: onToggle,
    );
  }

  factory CustomSwitch.customColorsAndBorders({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      value: value,
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
      onToggle: onToggle,
    );
  }

  factory CustomSwitch.withOnAndOffTextAndCustomTextColors({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
      showOnOff: true,
      activeTextColor: Colors.black,
      inactiveTextColor: Colors.blue[50]!,
      value: value,
      onToggle: onToggle,
    );
  }

  factory CustomSwitch.customSize({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
      width: 55.0,
      height: 25.0,
      valueFontSize: 12.0,
      toggleSize: 18.0,
      value: value,
      onToggle: onToggle,
    );
  }

  factory CustomSwitch.customBorderRadiusAndPadding({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
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
  }

  factory CustomSwitch.customText({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
      activeText: "All Good. Negative.",
      inactiveText: "Under Quarantine.",
      valueFontSize: 10.0,
      width: 110,
      borderRadius: 30.0,
      showOnOff: true,
      value: value,
      onToggle: onToggle,
    );
  }

  factory CustomSwitch.iconInToggle({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: const Color(0xFF6E40C9),
      inactiveToggleColor: const Color(0xFF2F363D),
      activeSwitchBorder: Border.all(
        color: const Color(0xFF3C1E70),
        width: 6.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: const Color(0xFFD1D5DA),
        width: 6.0,
      ),
      activeColor: const Color(0xFF271052),
      inactiveColor: Colors.white,
      activeIcon: const Icon(
        Icons.nightlight_round,
        color: Color(0xFFF8E3A1),
      ),
      inactiveIcon: const Icon(
        Icons.wb_sunny,
        color: Color(0xFFFFDF5D),
      ),
      value: value,
      onToggle: onToggle,
    );
  }

  factory CustomSwitch.imageAsToggleIcon({
    required ValueChanged<bool> onToggle,
    required bool value,
  }) {
    return CustomSwitch._(
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
        "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png",
      ),
      inactiveIcon: Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
      ),
      value: value,
      onToggle: onToggle,
    );
  }

  const CustomSwitch._({
    Key? key,
    required this.value,
    required this.onToggle,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.toggleColor = Colors.white,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.width = 70.0,
    this.height = 35.0,
    this.toggleSize = 25.0,
    this.valueFontSize = 16.0,
    this.borderRadius = 20.0,
    this.padding = 4.0,
    this.showOnOff = false,
    this.activeText,
    this.inactiveText,
    this.activeTextFontWeight,
    this.inactiveTextFontWeight,
    this.switchBorder,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.toggleBorder,
    this.activeToggleBorder,
    this.inactiveToggleBorder,
    this.activeIcon,
    this.inactiveIcon,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        key: key,
        value: value,
        onToggle: onToggle,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        activeTextColor: activeTextColor,
        inactiveTextColor: inactiveTextColor,
        toggleColor: toggleColor,
        activeToggleColor: activeToggleColor,
        inactiveToggleColor: inactiveToggleColor,
        width: width,
        height: height,
        toggleSize: toggleSize,
        valueFontSize: valueFontSize,
        borderRadius: borderRadius,
        padding: padding,
        showOnOff: showOnOff,
        activeText: activeText,
        inactiveText: inactiveText,
        activeTextFontWeight: activeTextFontWeight,
        inactiveTextFontWeight: inactiveTextFontWeight,
        switchBorder: switchBorder,
        activeSwitchBorder: activeSwitchBorder,
        inactiveSwitchBorder: inactiveSwitchBorder,
        toggleBorder: toggleBorder,
        activeToggleBorder: activeToggleBorder,
        inactiveToggleBorder: inactiveToggleBorder,
        activeIcon: activeIcon,
        inactiveIcon: inactiveIcon,
        duration: duration,
        disabled: disabled);
  }
}
