import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/blocs/custom_switch_cubit.dart';

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
class CustomSwitch extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomSwitchCubit(initialStatus),
      child: BlocBuilder<CustomSwitchCubit, bool>(
        // bloc: cubit,
        builder: (context, state) {
          return RepaintBoundary(
            child: title.isNotEmpty || subTitle.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title.isNotEmpty) Text(title),
                      if (subTitle.isNotEmpty)
                        Text(
                          subTitle,
                          style: const TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
                        ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          getFlutterSwitchWidget(context, state),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(tr("currentValueText", args: ["$state"])),
                          ),
                        ],
                      ),
                    ],
                  )
                : getFlutterSwitchWidget(context, state),
          );
        },
      ),
    );
  }

  Widget getFlutterSwitchWidget(BuildContext context, bool state) {
    return FlutterSwitch(
      value: state,
      width: width,
      height: height,
      toggleSize: toggleSize,
      borderRadius: borderRadius,
      padding: padding,
      toggleColor: toggleColor,
      switchBorder: switchBorder,
      toggleBorder: toggleBorder,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      showOnOff: showOnOff,
      activeTextColor: activeTextColor,
      inactiveTextColor: inactiveTextColor,
      valueFontSize: valueFontSize,
      activeText: activeText,
      inactiveText: inactiveText,
      activeToggleColor: activeToggleColor,
      inactiveToggleColor: inactiveToggleColor,
      activeSwitchBorder: activeSwitchBorder,
      inactiveSwitchBorder: inactiveSwitchBorder,
      activeIcon: activeIcon,
      inactiveIcon: inactiveIcon,
      onToggle: (val) {
        BlocProvider.of<CustomSwitchCubit>(context).updateState(val);
        if (onToggle != null) onToggle!(val);
      },
    );
  }
}
