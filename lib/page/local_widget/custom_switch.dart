import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

/// ## CustomSwitch
///
/// 이 위젯은 [FlutterSwitch]위젯과 함께 묶여서 사용되거나,
/// 상태 값이 연관되는 위젯을 묶어 놓은 위젯입니다.
///
/// 이 위젯은 아래와 같은 예시를 통해 사용할 수 있습니다.
/// ```dart
/// /* ...some code... */
/// CustomSwitch(
///   title: "스위치",
///   initialStatus: false,
/// ),
/// /* ...some code... */
/// ```
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

  /// 값을 지정할 경우, 스위치 위젯 상단에 제목 텍스트가 나타납니다.
  final String title;

  /// 값을 지정할 경우, 제목과 스위치 위젯 사이에 기울어진 글씨체로 부제목 텍스트가 나타납니다.
  final String subTitle;

  /// 반드시 값이 지정되어야하며 스위치 위젯의 최초 상태에만 관여합니다.
  final bool initialStatus;

  /// 스위치 위젯의 너비를 설정합니다.
  final double width;

  /// 스위치 위젯의 높이를 설정합니다.
  final double height;

  /// 스위치 위젯 안의 토글 사이즈를 설정합니다. 토글 사이즈는 지름을 기준으로 합니다.
  final double toggleSize;

  /// 스위치 위젯의 테두리 보더 두께를 설정합니다.
  final double borderRadius;

  /// 스위치 위젯의 테두리와 토글 사이의 패딩 값을 설정합니다.
  final double padding;

  /// 토글의 색상을 설정합니다.
  final Color toggleColor;

  /// 스위치 위젯의 테두리 보더를 설정합니다.
  final Border? switchBorder;

  /// 토글의 보더를 설정합니다.
  final Border? toggleBorder;

  /// 스위치 위젯의 상태가 `true`인 경우 채워질 색상을 설정합니다.
  final Color activeColor;

  /// 스위치 위젯의 상태가 `false`인 경우 채워질 색상을 설정합니다.
  final Color inactiveColor;

  /// - `true`인 경우 스위치 위젯 내부에 On/Off 텍스트를 표시합니다.
  /// - 기본 값은 false입니다.
  final bool showOnOff;

  /// [showOnOff]로 보여지는 텍스트 중 `true`일 때 보여지는 텍스트의 색상을 설정합니다.
  final Color activeTextColor;

  /// [showOnOff]로 보여지는 텍스트 중 `false`일 때 보여지는 텍스트의 색상을 설정합니다.
  final Color inactiveTextColor;

  /// [showOnOff]로 보여지는 텍스트의 크기를 설정합니다.
  final double valueFontSize;

  /// [showOnOff]로 보여지는 텍스트 중 `true`일 때 보여지는 텍스트의 문구를 설정합니다.
  final String? activeText;

  /// [showOnOff]로 보여지는 텍스트 중 `false`일 때 보여지는 텍스트의 문구를 설정합니다.
  final String? inactiveText;

  /// 스위치 위젯의 상태가 `true`인 경우 토글에 채워질 색상을 설정합니다.
  final Color? activeToggleColor;

  /// 스위치 위젯의 상태가 `false`인 경우 토글에 채워질 색상을 설정합니다.
  final Color? inactiveToggleColor;

  /// 스위치 위젯의 상태가 `true`인 경우 스위치 보더의 색상을 설정합니다.
  final Border? activeSwitchBorder;

  /// 스위치 위젯의 상태가 `false`인 경우 스위치 보더의 색상을 설정합니다.
  final Border? inactiveSwitchBorder;

  /// 스위치 위젯의 상태가 `true`인 경우 스위치 토글 안에 보여질 위젯을 설정합니다.
  final Widget? activeIcon;

  /// 스위치 위젯의 상태가 `false`인 경우 스위치 토글 안에 보여질 위젯을 설정합니다.
  final Widget? inactiveIcon;

  /// 스위치 위젯이 토글 될때마다 호출되는 함수를 지정합니다.
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

    return RepaintBoundary(
      child: widget.title.isNotEmpty || widget.subTitle.isNotEmpty
          ? Column(
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
            )
          : flutterSwitch,
    );
  }
}
