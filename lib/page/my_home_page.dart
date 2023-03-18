import 'package:flutter/material.dart';
import 'package:rs_flutter_test/page/local_widget/custom_switch.dart';
import 'package:rs_flutter_test/theme/colors.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.onChangeTheme, required this.switchinitials});

  final ValueChanged<ThemeMode> onChangeTheme;
  final List<bool> switchinitials;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterSwitch Demo"),
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
                toggleColor: firstToggleColor,
                switchBorder: Border.all(
                  color: firstBorderColor,
                  width: 6.0,
                ),
                toggleBorder: Border.all(
                  color: firstBorderColor,
                  width: 5.0,
                ),
                activeColor: firstActiveColor,
                inactiveColor: firstInactiveColor,
              ),
              const SizedBox(height: 20.0),
              CustomSwitch(
                title: "With 'On' and 'Off' text and custom text colors",
                initialStatus: false,
                showOnOff: true,
                activeTextColor: firstActiveTextColor,
                inactiveTextColor: firstInactiveTextColor,
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
                activeToggleColor: firstActiveToggleColor,
                inactiveToggleColor: firstInactiveToggleColor,
                activeSwitchBorder: Border.all(
                  color: firstActiveBorderColor,
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: firstInactiveBorderColor,
                  width: 6.0,
                ),
                activeColor: secondActiveColor,
                inactiveColor: secondInactiveColor,
                activeIcon: const Icon(
                  Icons.nightlight_round,
                  color: moonIconColor,
                ),
                inactiveIcon: const Icon(
                  Icons.wb_sunny,
                  color: sunIconColor,
                ),
                onToggle: (val) {
                  onChangeTheme(val ? ThemeMode.dark : ThemeMode.light);
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
                activeToggleColor: secondActiveToggleColor,
                inactiveToggleColor: secondInactiveToggleColor,
                activeSwitchBorder: Border.all(
                  color: secondActiveBorderColor,
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: secondInactiveBorderColor,
                  width: 6.0,
                ),
                activeColor: thirdActiveColor,
                inactiveColor: thirdInactiveColor,
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
    );
  }
}
