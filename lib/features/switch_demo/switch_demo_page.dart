import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'flutter_switch_demo_item.dart';
import '../../widgets/colum_with_space.dart';
import '../../widgets/custom_flutter_switch.dart';

class SwitchDemoPage extends StatefulWidget {
  const SwitchDemoPage({super.key});

  @override
  State<SwitchDemoPage> createState() => _SwitchDemoPageState();
}

class _SwitchDemoPageState extends State<SwitchDemoPage> {
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  bool status8 = false;
  bool isSwitchOn = false;

  Color _textColor = Colors.black;
  Color _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
  Color _scaffoldBgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: _textColor),
          bodyMedium: TextStyle(color: _textColor),
        ),
      ),
      child: Scaffold(
        backgroundColor: _scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: _appBarColor,
          title: const Text(
            "FlutterSwitch Demo",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlutterSwitch(
              value: isSwitchOn,
              onToggle: (value) {
                setState(() {
                  isSwitchOn = value;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ColumnWithSpace(
                space: 20.0,
                children: [
                  FlutterSwitchDemoItem(
                      title: "Default",
                      value: status1,
                      flutterSwitch: CustomFlutterSwitch.defaultSwitch(
                          onToggle: (val) {
                            setState(() {
                              status1 = val;
                            });
                          },
                          value: status1)),
                  FlutterSwitchDemoItem(
                      title: "Custom Colors and Borders",
                      value: status2,
                      flutterSwitch: CustomFlutterSwitch.customColorsAndBorders(
                          onToggle: (val) {
                            setState(() {
                              status2 = val;
                            });
                          },
                          value: status2)),
                  FlutterSwitchDemoItem(
                      title: "With 'On' and 'Off' text and custom text colors",
                      value: status3,
                      flutterSwitch: CustomFlutterSwitch.withOnAndOffTextAndCustomTextColors(
                          onToggle: (val) {
                            setState(() {
                              status3 = val;
                            });
                          },
                          value: status3)),
                  FlutterSwitchDemoItem(
                      title: "Custom size",
                      value: status4,
                      flutterSwitch: CustomFlutterSwitch.customSize(
                          onToggle: (val) {
                            setState(() {
                              status4 = val;
                            });
                          },
                          value: status4)),
                  FlutterSwitchDemoItem(
                      title: "Custom border radius and padding",
                      value: status5,
                      flutterSwitch: CustomFlutterSwitch.customBorderRadiusAndPadding(
                          onToggle: (val) {
                            setState(() {
                              status5 = val;
                            });
                          },
                          value: status5)),
                  FlutterSwitchDemoItem(
                      title: "Custom text",
                      value: status6,
                      flutterSwitch: CustomFlutterSwitch.customText(
                          onToggle: (val) {
                            setState(() {
                              status6 = val;
                            });
                          },
                          value: status6)),
                  FlutterSwitchDemoItem(
                      title: "Icon in toggle",
                      description:
                      "Inspired by the colors from Github Dark Mode switch",
                      value: status7,
                      flutterSwitch: CustomFlutterSwitch.iconInToggle(
                          onToggle: (val) {
                            setState(() {
                              status7 = val;
                              if (val) {
                                _textColor = Colors.white;
                                _appBarColor =
                                const Color.fromRGBO(22, 27, 34, 1);
                                _scaffoldBgColor = const Color(0xFF0D1117);
                              } else {
                                _textColor = Colors.black;
                                _appBarColor =
                                const Color.fromRGBO(36, 41, 46, 1);
                                _scaffoldBgColor = Colors.white;
                              }
                            });
                          },
                          value: status7)),
                  FlutterSwitchDemoItem(
                      title: "Image as toggle icon",
                      value: status8,
                      flutterSwitch: CustomFlutterSwitch.imageAsToggleIcon(
                          onToggle: (val) {
                            setState(() {
                              status8 = val;
                            });
                          },
                          value: status8)),
                ],
              )),
        ),
      ),
    );
  }
}