import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/util/r_color.dart';

Widget titleView(String title, {String? secondTitle}) {
  Widget? contentView = secondTitle != null
      ? Text(
          secondTitle,
          style: const TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        )
      : Container();
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), contentView],
    ),
  );
}

Widget buttonValueView(bool value) {
  return Container(
    alignment: Alignment.centerRight,
    child: Text("Value: $value"),
  );
}

Widget defaultView(bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Default"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            value: switchValue,
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget customColorBorderView(bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Custom Colors and Borders"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            width: 100.0,
            height: 55.0,
            toggleSize: 45.0,
            value: switchValue,
            borderRadius: 30.0,
            padding: 2.0,
            toggleColor: RsupportColor.white_02,
            switchBorder: Border.all(
              color: RsupportColor.blue_01,
              width: 6.0,
            ),
            toggleBorder: Border.all(
              color: RsupportColor.blue_01,
              width: 5.0,
            ),
            activeColor: RsupportColor.blue_02,
            inactiveColor: RsupportColor.black_05,
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget customTextColorView(bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("With 'On' and 'Off' text and custom text colors"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
              showOnOff: true,
              activeTextColor: RsupportColor.black_01,
              inactiveTextColor: Colors.blue[50]!,
              value: switchValue,
              onToggle: callback),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget customSizeView(bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Custom size"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            width: 55.0,
            height: 25.0,
            valueFontSize: 12.0,
            toggleSize: 18.0,
            value: switchValue,
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget customBorderRadiusPaddingView(
    bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Custom border radius and padding"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            width: 125.0,
            height: 55.0,
            valueFontSize: 25.0,
            toggleSize: 45.0,
            value: switchValue,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget customTextView(bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Custom text"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            activeText: "All Good. Negative.",
            inactiveText: "Under Quarantine.",
            value: switchValue,
            valueFontSize: 10.0,
            width: 110,
            borderRadius: 30.0,
            showOnOff: true,
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget iconToggleButtonView(bool switchValue, Function(bool) callback) {
  debugPrint(">> iconToggleButtonView : $switchValue");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Icon in toggle",
          secondTitle: "Inspired by the colors from Github Dark Mode switch"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            width: 100.0,
            height: 55.0,
            toggleSize: 45.0,
            value: switchValue,
            borderRadius: 30.0,
            padding: 2.0,
            activeToggleColor: RsupportColor.purple_01,
            inactiveToggleColor: RsupportColor.blue_03,
            activeSwitchBorder: Border.all(
              color: RsupportColor.purple_02,
              width: 6.0,
            ),
            inactiveSwitchBorder: Border.all(
              color: RsupportColor.white_03,
              width: 6.0,
            ),
            activeColor: RsupportColor.purple_03,
            inactiveColor: RsupportColor.white_01,
            activeIcon: Icon(
              Icons.nightlight_round,
              color: RsupportColor.yellow_02,
            ),
            inactiveIcon: Icon(
              Icons.wb_sunny,
              color: RsupportColor.yellow_01,
            ),
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
      const SizedBox(height: 20.0),
    ],
  );
}

Widget iconToggleImageButtonView(bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView("Image as toggle icon"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterSwitch(
            width: 100.0,
            height: 55.0,
            toggleSize: 45.0,
            value: switchValue,
            borderRadius: 30.0,
            padding: 2.0,
            activeToggleColor: RsupportColor.blue_04,
            inactiveToggleColor: RsupportColor.blue_05,
            activeSwitchBorder: Border.all(
              color: RsupportColor.blue_05,
              width: 6.0,
            ),
            inactiveSwitchBorder: Border.all(
              color: RsupportColor.blue_06,
              width: 6.0,
            ),
            activeColor: RsupportColor.blue_07,
            inactiveColor: RsupportColor.blue_08,
            activeIcon: Image.network(
              "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png",
            ),
            inactiveIcon: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
            ),
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
    ],
  );
}
