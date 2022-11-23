import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/util/images.dart';
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

Widget defaultView(
    String title, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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

Widget customColorBorderView(
    String title, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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

Widget customTextColorView(
    String title, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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

Widget customSizeView(String title, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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
    String title, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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

Widget customTextView(String title, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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

Widget iconToggleButtonView(
    String title, String subTitle, bool switchValue, Function(bool) callback) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title, secondTitle: subTitle),
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

Widget iconToggleImageButtonView(String title, bool switchValue,
    String activeIconUrl, String inActiveIconUrl, Function(bool) callback) {
  var activeIcon = imageIcon(activeIconUrl);
  var inActiveIcon = imageIcon(inActiveIconUrl);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleView(title),
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
            activeIcon: activeIcon,
            inactiveIcon: inActiveIcon,
            onToggle: callback,
          ),
          buttonValueView(switchValue)
        ],
      ),
    ],
  );
}

Widget imageIcon(String path) {
  return Image.network(
    path,
    errorBuilder: (context, exception, stackTrace) {
      return Image.asset(Images.flutterIcon);
    },
  );
}
