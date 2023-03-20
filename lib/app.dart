import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/src/pages/home.dart';
import 'constants.dart';
import 'src/components/theme_mode.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeColor themeColor = ThemeColor();
  void updateMode(bool val) {
    setState(() {
      themeColor.themeColorChange(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: themeColor.textColor),
          bodyText2: TextStyle(color: themeColor.textColor),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor.appBarColor,
          title: Text(
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
        body: MyHomePage(changeTheme: updateMode, themeColor: themeColor),
      ),
    );
  }
}
