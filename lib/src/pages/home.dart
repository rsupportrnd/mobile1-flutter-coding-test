import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/constants.dart';
import 'package:rs_flutter_test/src/components/show_value.dart';
import 'package:rs_flutter_test/src/components/theme_mode.dart';

class MyHomePage extends StatefulWidget {
  ThemeColor themeColor;
  final Function(bool val) changeTheme;
  MyHomePage({
    Key? key,
    required this.themeColor,
    required this.changeTheme,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //wrong ImageLink
  var imageLink =
      "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeColor.scaffoldBgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Button1
              const Text("Default"),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    value: status1,
                    onToggle: (val) {
                      setState(() {
                        status1 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status1),
                ],
              ),

              const SizedBox(height: 20.0),

              //Button2
              const Text("Custom Colors and Borders"),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    width: 100.0,
                    height: 55.0,
                    toggleSize: 45.0,
                    value: status2,
                    borderRadius: 30.0,
                    padding: 2.0,
                    toggleColor: toggleColor,
                    switchBorder: Border.all(
                      color: borderColor,
                      width: defaultBorderWidth,
                    ),
                    toggleBorder: Border.all(
                      color: borderColor,
                      width: 5.0,
                    ),
                    activeColor: Color.fromRGBO(51, 226, 255, 1),
                    inactiveColor: Colors.black38,
                    onToggle: (val) {
                      setState(() {
                        status2 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status2),
                ],
              ),

              const SizedBox(height: 20.0),

              //Button3
              Text("With 'On' and 'Off' text and custom text colors"),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    showOnOff: true,
                    activeTextColor: Colors.black,
                    inactiveTextColor: Colors.blue[50]!,
                    value: status3,
                    onToggle: (val) {
                      setState(() {
                        status3 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status3),
                ],
              ),

              SizedBox(height: 20.0),
              Text("Custom size"),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    width: 55.0,
                    height: 25.0,
                    valueFontSize: 12.0,
                    toggleSize: 18.0,
                    value: status4,
                    onToggle: (val) {
                      setState(() {
                        status4 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status4),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Custom border radius and padding"),
              SizedBox(height: 10.0),

              //Button4
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    width: 125.0,
                    height: 55.0,
                    valueFontSize: 25.0,
                    toggleSize: 45.0,
                    value: status5,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        status5 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status5),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Custom text"),
              SizedBox(height: 10.0),

              //Button5
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    activeText: "All Good. Negative.",
                    inactiveText: "Under Quarantine.",
                    value: status6,
                    valueFontSize: 10.0,
                    width: 110,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        status6 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status6),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Icon in toggle"),
              Text(
                "Inspired by the colors from Github Dark Mode switch",
                style: TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10.0),

              //Button6
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    width: 100.0,
                    height: 55.0,
                    toggleSize: 45.0,
                    value: status7,
                    borderRadius: 30.0,
                    padding: 2.0,
                    activeToggleColor: Color(0xFF6E40C9),
                    inactiveToggleColor: Color(0xFF2F363D),
                    activeSwitchBorder: Border.all(
                      color: Color(0xFF3C1E70),
                      width: defaultBorderWidth,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: Color(0xFFD1D5DA),
                      width: defaultBorderWidth,
                    ),
                    activeColor: Color(0xFF271052),
                    inactiveColor: Colors.white,
                    activeIcon: Icon(
                      Icons.nightlight_round,
                      color: Color(0xFFF8E3A1),
                    ),
                    inactiveIcon: Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFFFDF5D),
                    ),
                    onToggle: (val) {
                      setState(() {
                        status7 = val;
                        widget.changeTheme(val);
                      });
                    },
                  ),
                  ShowButtonValue(statas: status7),
                ],
              ),

              SizedBox(height: 20.0),
              Text("Image as toggle icon"),
              SizedBox(height: 10.0),
              //Button7
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlutterSwitch(
                    width: 100.0,
                    height: 55.0,
                    toggleSize: 45.0,
                    value: status8,
                    borderRadius: 30.0,
                    padding: 2.0,
                    activeToggleColor: Color(0xFF0082C8),
                    inactiveToggleColor: Color(0xFF01579B),
                    activeSwitchBorder: Border.all(
                      color: Color(0xFF00D2B8),
                      width: defaultBorderWidth,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: Color(0xFF29B6F6),
                      width: defaultBorderWidth,
                    ),
                    activeColor: Color(0xFF55DDCA),
                    inactiveColor: Color(0xFF54C5F8),
                    activeIcon: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                    ),
                    inactiveIcon: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                    ),
                    onToggle: (val) {
                      setState(() {
                        status8 = val;
                      });
                    },
                  ),
                  ShowButtonValue(statas: status8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
