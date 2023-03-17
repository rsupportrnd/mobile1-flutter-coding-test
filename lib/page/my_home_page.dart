import 'package:flutter/material.dart';
import 'package:rs_flutter_test/page/local_widget/custom_switch.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _textColor = Colors.black;
  Color _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
  Color _scaffoldBgcolor = Colors.white;

  List<bool> switchinitials = [false, true, false, false, false, false, false, false];
  bool isSwitchOn = false;

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
        backgroundColor: _scaffoldBgcolor,
        appBar: AppBar(
          backgroundColor: _appBarColor,
          title: const Text(
            "FlutterSwitch Demo",
            style: TextStyle(color: Colors.white),
          ),
          actions: const [
            CustomSwitch(initialStatus: false),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CustomSwitch(title: "Default", initialStatus: false),
                const SizedBox(height: 20.0),
                CustomSwitch(
                  title: "Custom Colors and Borders",
                  width: 100.0,
                  height: 55.0,
                  toggleSize: 45.0,
                  initialStatus: true,
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
                ),
                const SizedBox(height: 20.0),
                CustomSwitch(
                  title: "With 'On' and 'Off' text and custom text colors",
                  initialStatus: false,
                  showOnOff: true,
                  activeTextColor: Colors.black,
                  inactiveTextColor: Colors.blue[50]!,
                ),
                const SizedBox(height: 20.0),
                const CustomSwitch(
                  title: "Custom size",
                  initialStatus: false,
                  width: 55.0,
                  height: 25.0,
                  toggleSize: 18.0,
                  valueFontSize: 12.0,
                ),
                const SizedBox(height: 20.0),
                const CustomSwitch(
                  title: "Custom border radius and padding",
                  initialStatus: false,
                  width: 125.0,
                  height: 55.0,
                  valueFontSize: 25.0,
                  toggleSize: 45.0,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                ),
                const SizedBox(height: 20.0),
                const CustomSwitch(
                  title: "Custom text",
                  initialStatus: false,
                  activeText: "All Good. Negative.",
                  inactiveText: "Under Quarantine.",
                  valueFontSize: 10.0,
                  width: 110,
                  borderRadius: 30.0,
                  showOnOff: true,
                ),
                const SizedBox(height: 20.0),
                CustomSwitch(
                  title: "Icon in toggle",
                  subTitle: "Inspired by the colors from Github Dark Mode switch",
                  initialStatus: false,
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
                  onToggle: (val) {
                    setState(() {
                      if (val) {
                        _textColor = Colors.white;
                        _appBarColor = const Color.fromRGBO(22, 27, 34, 1);
                        _scaffoldBgcolor = const Color(0xFF0D1117);
                      } else {
                        _textColor = Colors.black;
                        _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
                        _scaffoldBgcolor = Colors.white;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                CustomSwitch(
                  title: "Image as toggle icon",
                  initialStatus: false,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
