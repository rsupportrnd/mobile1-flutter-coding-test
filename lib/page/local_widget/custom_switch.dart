import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    this.title = '',
    this.subTitle = '',
    required this.initialStatus,
    this.width = 70.0,
    this.height = 35.0,
    this.toggleSize = 25.0,
    this.borderRadius = 20.0,
    this.padding = 4.0,
    this.toggleColor = Colors.white,
    this.switchBorder,
    this.toggleBorder,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.showOnOff = false,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.valueFontSize = 16.0,
    this.activeText,
    this.inactiveText,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.activeIcon,
    this.inactiveIcon,
    this.onToggle,
  });

  final String title;
  final String subTitle;
  final bool initialStatus;
  final double width;
  final double height;
  final double toggleSize;
  final double borderRadius;
  final double padding;
  final Color toggleColor;
  final Border? switchBorder;
  final Border? toggleBorder;
  final Color activeColor;
  final Color inactiveColor;
  final bool showOnOff;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final double valueFontSize;
  final String? activeText;
  final String? inactiveText;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final Border? activeSwitchBorder;
  final Border? inactiveSwitchBorder;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final ValueChanged<bool>? onToggle;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool status;

  @override
  void initState() {
    status = widget.initialStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget flutterSwitch = FlutterSwitch(
      value: status,
      width: widget.width,
      height: widget.height,
      toggleSize: widget.toggleSize,
      borderRadius: widget.borderRadius,
      padding: widget.padding,
      toggleColor: widget.toggleColor,
      switchBorder: widget.switchBorder,
      toggleBorder: widget.toggleBorder,
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      showOnOff: widget.showOnOff,
      activeTextColor: widget.activeTextColor,
      inactiveTextColor: widget.inactiveTextColor,
      valueFontSize: widget.valueFontSize,
      activeText: widget.activeText,
      inactiveText: widget.inactiveText,
      activeToggleColor: widget.activeToggleColor,
      inactiveToggleColor: widget.inactiveToggleColor,
      activeSwitchBorder: widget.activeSwitchBorder,
      inactiveSwitchBorder: widget.inactiveSwitchBorder,
      activeIcon: widget.activeIcon,
      inactiveIcon: widget.inactiveIcon,
      onToggle: (val) {
        setState(() {
          status = val;
        });
        if (widget.onToggle != null) widget.onToggle!(val);
      },
    );

    if (widget.title.isNotEmpty || widget.subTitle.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty) Text(widget.title),
          if (widget.subTitle.isNotEmpty)
            Text(
              widget.subTitle,
              style: const TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
            ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              flutterSwitch,
              Container(
                alignment: Alignment.centerRight,
                child: Text("Value: $status"),
              ),
            ],
          ),
        ],
      );
    } else {
      return flutterSwitch;
    }
  }
}
