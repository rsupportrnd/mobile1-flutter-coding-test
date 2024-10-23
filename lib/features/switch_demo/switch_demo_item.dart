import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../widgets/custom_switch.dart';

enum CustomSwitchType {
  defaultSwitch(title: "Default"),
  customColorsAndBorders(title: "Custom Colors and Borders"),
  withOnAndOffTextAndCustomTextColors(
      title: "With 'On' and 'Off' text and custom text colors"),
  customSize(title: "Custom size"),
  customBorderRadiusAndPadding(title: "Custom border radius and padding"),
  customText(title: "Custom text"),
  iconInToggle(
      title: "Icon in toggle",
      description: "Inspired by the colors from Github Dark Mode switch"),
  imageAsToggleIcon(title: "Image as toggle icon");

  final String title;
  final String? description;

  const CustomSwitchType({
    required this.title,
    this.description,
  });
}

class SwitchDemoItem extends HookWidget {
  const SwitchDemoItem(
      {super.key,
      required this.type,
      required this.initialValue,
      this.onToggled});

  final CustomSwitchType type;
  final bool initialValue;
  final Function(bool)? onToggled;

  @override
  Widget build(BuildContext context) {
    final isSwitchOn = useState(initialValue);

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(type.title),
          if (type.description != null)
            Text(
              type.description ?? "",
              style: const TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildSwitch(
                  onToggle: (val) {
                    isSwitchOn.value = val;
                    onToggled?.call(val);
                  },
                  value: isSwitchOn.value),
              Container(
                alignment: Alignment.centerRight,
                child: Text("Value: ${isSwitchOn.value}"),
              ),
            ],
          )
        ]);
  }

  Widget _buildSwitch(
      {required void Function(bool) onToggle, required bool value}) {
    switch (type) {
      case CustomSwitchType.customColorsAndBorders:
        return CustomSwitch.customColorsAndBorders(
            onToggle: onToggle, value: value);
      case CustomSwitchType.withOnAndOffTextAndCustomTextColors:
        return CustomSwitch.withOnAndOffTextAndCustomTextColors(
            onToggle: onToggle, value: value);
      case CustomSwitchType.customSize:
        return CustomSwitch.customSize(onToggle: onToggle, value: value);
      case CustomSwitchType.customBorderRadiusAndPadding:
        return CustomSwitch.customBorderRadiusAndPadding(
            onToggle: onToggle, value: value);
      case CustomSwitchType.customText:
        return CustomSwitch.customText(onToggle: onToggle, value: value);
      case CustomSwitchType.iconInToggle:
        return CustomSwitch.iconInToggle(onToggle: onToggle, value: value);
      case CustomSwitchType.imageAsToggleIcon:
        return CustomSwitch.imageAsToggleIcon(onToggle: onToggle, value: value);
      default:
        return CustomSwitch.defaultSwitch(onToggle: onToggle, value: value);
    }
  }
}
