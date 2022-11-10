import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/src/provider/switch_provider.dart';

enum SwitchTypes {
  appBarSwitch,
  defaultSwitch,
  customColorBorderSwitch,
  customOnOffTextSwitch,
  customSizeSwitch,
  customBorderPaddingSwitch,
  customtextSwitch,
  iconToggleSwitch,
  imageAsToggleSwitch,
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SwitchProvider>(
      builder: (context, provider, child) => Theme(
        data: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: provider.textColor),
            bodyText2: TextStyle(color: provider.textColor),
          ),
        ),
        child: Scaffold(
          backgroundColor: provider.scaffoldBgColor,
          appBar: AppBar(
            backgroundColor: provider.appBarColor,
            title: const Text(
              "FlutterSwitch Demo",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              FlutterSwitch(
                value: provider.getStatus(SwitchTypes.appBarSwitch),
                onToggle: (val) {
                  provider.setValue(val, SwitchTypes.appBarSwitch);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Default"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        value: provider.getStatus(SwitchTypes.defaultSwitch),
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.defaultSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.defaultSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom Colors and Borders"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: provider.getStatus(SwitchTypes.customColorBorderSwitch),
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
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.customColorBorderSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.customColorBorderSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("With 'On' and 'Off' text and custom text colors"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Colors.blue[50]!,
                        value: provider.getStatus(SwitchTypes.customOnOffTextSwitch),
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.customOnOffTextSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.customOnOffTextSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom size"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 55.0,
                        height: 25.0,
                        valueFontSize: 12.0,
                        toggleSize: 18.0,
                        value: provider.getStatus(SwitchTypes.customSizeSwitch),
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.customSizeSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.customSizeSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom border radius and padding"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 125.0,
                        height: 55.0,
                        valueFontSize: 25.0,
                        toggleSize: 45.0,
                        value: provider.getStatus(SwitchTypes.customBorderPaddingSwitch),
                        borderRadius: 30.0,
                        padding: 8.0,
                        showOnOff: true,
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.customBorderPaddingSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.customBorderPaddingSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom text"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        activeText: "All Good. Negative.",
                        inactiveText: "Under Quarantine.",
                        value: provider.getStatus(SwitchTypes.customtextSwitch),
                        valueFontSize: 10.0,
                        width: 110,
                        borderRadius: 30.0,
                        showOnOff: true,
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.customtextSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.customtextSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Icon in toggle"),
                  const Text(
                    "Inspired by the colors from Github Dark Mode switch",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: provider.getStatus(SwitchTypes.iconToggleSwitch),
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
                          provider.setValue(val, SwitchTypes.iconToggleSwitch);
                          provider.setThemeColor(val);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.iconToggleSwitch)}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Image as toggle icon"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: provider.getStatus(SwitchTypes.imageAsToggleSwitch),
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
                        onToggle: (val) {
                          provider.setValue(val, SwitchTypes.imageAsToggleSwitch);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${provider.getStatus(SwitchTypes.imageAsToggleSwitch)}",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
