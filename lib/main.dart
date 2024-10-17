import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/custom_flutter_switch.dart';
import 'package:rs_flutter_test/flutter_switch_demo_item.dart';

import 'colum_with_space.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                    flutterSwitch: CustomFlutterSwitch.blueBorderSwitch(
                        onToggle: (val) {
                          setState(() {
                            status2 = val;
                          });
                        },
                        value: status2)),
                FlutterSwitchDemoItem(
                    title: "With 'On' and 'Off' text and custom text colors",
                    value: status3,
                    flutterSwitch: CustomFlutterSwitch.onOffSwitch(
                        onToggle: (val) {
                          setState(() {
                            status3 = val;
                          });
                        },
                        value: status3)),
                FlutterSwitchDemoItem(
                    title: "With 'On' and 'Off' text and custom text colors",
                    value: status4,
                    flutterSwitch: CustomFlutterSwitch.miniSwitch(
                        onToggle: (val) {
                          setState(() {
                            status4 = val;
                          });
                        },
                        value: status4)),
                FlutterSwitchDemoItem(
                    title: "Custom border radius and padding",
                    value: status5,
                    flutterSwitch: CustomFlutterSwitch.bigSwitch(
                        onToggle: (val) {
                          setState(() {
                            status5 = val;
                          });
                        },
                        value: status5)),
                FlutterSwitchDemoItem(
                    title: "Custom text",
                    value: status6,
                    flutterSwitch: CustomFlutterSwitch.testSwitch(
                        onToggle: (val) {
                          setState(() {
                            status6 = val;
                          });
                        },
                        value: status6)),
                FlutterSwitchDemoItem(
                    title: "Icon in toggle",
                    description: "Inspired by the colors from Github Dark Mode switch",
                    value: status7,
                    flutterSwitch: CustomFlutterSwitch.darkModeSwitch(
                        onToggle: (val) {
                          setState(() {
                            status7 = val;
                            if (val) {
                              _textColor = Colors.white;
                              _appBarColor = const Color.fromRGBO(22, 27, 34, 1);
                              _scaffoldBgColor = const Color(0xFF0D1117);
                            } else {
                              _textColor = Colors.black;
                              _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
                              _scaffoldBgColor = Colors.white;
                            }
                          });
                        },
                        value: status7)),
                FlutterSwitchDemoItem(
                    title: "Image as toggle icon",
                    value: status8,
                    flutterSwitch: CustomFlutterSwitch.imageSwitch(
                        onToggle: (val) {
                          setState(() {
                            status8 = val;
                          });
                        },
                        value: status8)),
              ],
            )
          ),
        ),
      ),
    );
  }
}
