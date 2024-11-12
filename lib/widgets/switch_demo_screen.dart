import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/models/enums/switch_type.dart';
import 'package:rs_flutter_test/notifiers/switch_demo_screen_notifier.dart';
import 'package:rs_flutter_test/widgets/switch_section.dart';
import 'package:rs_flutter_test/widgets/typed_flutter_switch.dart';

const Color _kTextColor = Colors.black;
const Color _kAppBarColor = Color.fromRGBO(36, 41, 46, 1);
const Color _kScaffoldBgColor = Colors.white;

const Color _kDarkTextColor = Colors.white;
const Color _kDarkAppBarColor = Color.fromRGBO(22, 27, 34, 1);
const Color _kDarkScaffoldBgColor = Color(0xFF0D1117);

class SwitchDemoScreen extends StatelessWidget {
  const SwitchDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var notifier = context.watch<SwitchDemoScreenNotifier>();
    var isDarkMode = notifier.status7;
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyLarge:
              TextStyle(color: isDarkMode ? _kDarkTextColor : _kTextColor),
          bodyMedium:
              TextStyle(color: isDarkMode ? _kDarkTextColor : _kTextColor),
        ),
      ),
      child: Scaffold(
        backgroundColor: isDarkMode ? _kDarkScaffoldBgColor : _kScaffoldBgColor,
        appBar: AppBar(
          backgroundColor: isDarkMode ? _kDarkAppBarColor : _kAppBarColor,
          title: const Text(
            'FlutterSwitch Demo',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TypedFlutterSwitch(
              type: SwitchType.normal,
              value: notifier.isSwitchOn,
              onToggle: (value) => notifier.isSwitchOn = value,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SwitchSection(
                  title: 'Default',
                  tail: 'Value: ${notifier.status1}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.normal,
                    value: notifier.status1,
                    onToggle: (value) => notifier.status1 = value,
                  ),
                ),
                SwitchSection(
                  title: 'Custom Colors and Borders',
                  tail: 'Value: ${notifier.status2}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.colorsAndBorders,
                    value: notifier.status2,
                    onToggle: (value) => notifier.status2 = value,
                  ),
                ),
                SwitchSection(
                  title: "With 'On' and 'Off' text and custom text colors",
                  tail: 'Value: ${notifier.status3}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.onAndOff,
                    value: notifier.status3,
                    onToggle: (value) => notifier.status3 = value,
                  ),
                ),
                SwitchSection(
                  title: 'Custom size',
                  tail: 'Value: ${notifier.status4}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.customSize,
                    value: notifier.status4,
                    onToggle: (value) => notifier.status4 = value,
                  ),
                ),
                SwitchSection(
                  title: 'Custom border radius and padding',
                  tail: 'Value: ${notifier.status5}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.borderRadiusAndPadding,
                    value: notifier.status5,
                    onToggle: (value) => notifier.status5 = value,
                  ),
                ),
                SwitchSection(
                  title: 'Custom text',
                  tail: 'Value: ${notifier.status6}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.customText,
                    value: notifier.status6,
                    onToggle: (value) => notifier.status6 = value,
                  ),
                ),
                SwitchSection(
                  title: 'Icon in toggle',
                  subtitle:
                      'Inspired by the colors from Github Dark Mode switch',
                  tail: 'Value: ${notifier.status7}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.iconInToggle,
                    value: notifier.status7,
                    onToggle: (value) => notifier.status7 = value,
                  ),
                ),
                SwitchSection(
                  title: 'Image as toggle icon',
                  tail: 'Value: ${notifier.status8}',
                  switchBuilder: (_) => TypedFlutterSwitch(
                    type: SwitchType.imageAsToggleIcon,
                    value: notifier.status8,
                    onToggle: (value) => notifier.status8 = value,
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
