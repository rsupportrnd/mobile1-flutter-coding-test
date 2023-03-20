import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/switch_provider.dart';

enum ShowCaseSwitchType {
  unknown('Unknown'),
  appBarActionSwitch('AppBarAction'),
  defaultSwitch('Default'),
  customColorsAndBorders('Custom Colors and borders'),
  withTextCustomColor('With \'On\' and \'Off\' text and custom text colors'),
  customSize('Custom size'),
  customBorderRadiusAndPadding('Custom border radius and padding'),
  customText('Custom text'),
  darkModeSwitch('Icon in toggle'),
  imageAsToggleIcon('Image as toggle icon');

  final String name;
  const ShowCaseSwitchType(this.name);

  factory ShowCaseSwitchType.createFromName(String name) {
    return ShowCaseSwitchType.values.firstWhere(
      (element) => element.name == name,
      orElse: () => ShowCaseSwitchType.unknown,
    );
  }
}

abstract class ShowCaseSwitchStatusItem extends StatelessWidget {
  final ShowCaseSwitchType type;
  final ValueChanged<bool>? onValueChanged;

  const ShowCaseSwitchStatusItem({
    super.key,
    required this.type,
    this.onValueChanged,
  });

  factory ShowCaseSwitchStatusItem.create(
    ShowCaseSwitchType type, {
    ValueChanged<bool>? onValueChanged,
  }) {
    switch (type) {
      case ShowCaseSwitchType.defaultSwitch:
        return DefaultSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.customColorsAndBorders:
        return CustomColorsSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.withTextCustomColor:
        return CustomTextColorsSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.customSize:
        return CustomSizeSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.customBorderRadiusAndPadding:
        return CustomBorderSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.customText:
        return CustomTextSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.darkModeSwitch:
        return DarkModeToggleSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      case ShowCaseSwitchType.imageAsToggleIcon:
        return ImageAsToggleIconSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
      default:
        return DefaultSwitchItem(
          type: type,
          onValueChanged: onValueChanged,
        );
    }
  }

  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(type.name),
    );
  }

  Widget buildStatus(bool value) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        'Value: $value',
      ),
    );
  }

  Widget buildSwitch(bool value, ValueChanged<bool> onToggle);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(),
        Consumer<SwitchProvider>(
          builder: (context, switchProvider, _) {
            final switchValue = switchProvider.isActive(type.name);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSwitch(switchValue, (_) {
                  switchProvider.toggleSwitch(type.name);
                  onValueChanged?.call(switchProvider.isActive(type.name));
                }),
                buildStatus(switchValue),
              ],
            );
          },
        ),
      ],
    );
  }
}

class DefaultSwitchItem extends ShowCaseSwitchStatusItem {
  const DefaultSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.defaultSwitch,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      value: value,
      onToggle: onToggle,
    );
  }
}

class CustomColorsSwitchItem extends ShowCaseSwitchStatusItem {
  const CustomColorsSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.customColorsAndBorders,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
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
}

class CustomTextColorsSwitchItem extends ShowCaseSwitchStatusItem {
  const CustomTextColorsSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.withTextCustomColor,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      showOnOff: true,
      activeTextColor: Colors.black,
      inactiveTextColor: Colors.blue[50]!,
      value: value,
      onToggle: onToggle,
    );
  }
}

class CustomSizeSwitchItem extends ShowCaseSwitchStatusItem {
  const CustomSizeSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.customSize,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      width: 55.0,
      height: 25.0,
      valueFontSize: 12.0,
      toggleSize: 18.0,
      value: value,
      onToggle: onToggle,
    );
  }
}

class CustomBorderSwitchItem extends ShowCaseSwitchStatusItem {
  const CustomBorderSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.customBorderRadiusAndPadding,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      width: 125.0,
      height: 55.0,
      valueFontSize: 25.0,
      toggleSize: 45.0,
      value: value,
      borderRadius: 30.0,
      padding: 8.0,
      showOnOff: true,
      onToggle: onToggle,
    );
  }
}

class CustomTextSwitchItem extends ShowCaseSwitchStatusItem {
  const CustomTextSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.customText,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      activeText: "All Good. Negative.",
      inactiveText: "Under Quarantine.",
      value: value,
      valueFontSize: 10.0,
      width: 110,
      borderRadius: 30.0,
      showOnOff: true,
      onToggle: onToggle,
    );
  }
}

class DarkModeToggleSwitchItem extends ShowCaseSwitchStatusItem {
  const DarkModeToggleSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.darkModeSwitch,
    super.onValueChanged,
  });

  @override
  Widget buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type.name),
        const Text(
          'Inspired by the colors from Github Dark Mode switch',
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      value: value,
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
      onToggle: onToggle,
    );
  }
}

class ImageAsToggleIconSwitchItem extends ShowCaseSwitchStatusItem {
  final activeIconUrl =
      'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png';
  final inactiveIconUrl =
      'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png';

  const ImageAsToggleIconSwitchItem({
    super.key,
    super.type = ShowCaseSwitchType.imageAsToggleIcon,
    super.onValueChanged,
  });

  @override
  Widget buildSwitch(bool value, ValueChanged<bool> onToggle) {
    return FlutterSwitch(
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      value: value,
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
      activeIcon: Image.network(activeIconUrl),
      inactiveIcon: Image.network(inactiveIconUrl),
      onToggle: onToggle,
    );
  }
}
