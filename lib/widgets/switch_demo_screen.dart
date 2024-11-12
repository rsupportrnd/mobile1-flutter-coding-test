import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/models/enums/switch_type.dart';
import 'package:rs_flutter_test/notifiers/switch_demo_screen_notifier.dart';
import 'package:rs_flutter_test/widgets/switch_section.dart';

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
            FlutterSwitch(
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
                  type: SwitchType.normal,
                  value: notifier.status1,
                  onToggle: (value) => notifier.status1 = value,
                ),
                SwitchSection(
                  type: SwitchType.colorsAndBorders,
                  value: notifier.status2,
                  onToggle: (value) => notifier.status2 = value,
                ),
                SwitchSection(
                  type: SwitchType.onAndOff,
                  value: notifier.status3,
                  onToggle: (value) => notifier.status3 = value,
                ),
                SwitchSection(
                  type: SwitchType.customSize,
                  value: notifier.status4,
                  onToggle: (value) => notifier.status4 = value,
                ),
                SwitchSection(
                  type: SwitchType.borderRadiusAndPadding,
                  value: notifier.status5,
                  onToggle: (value) => notifier.status5 = value,
                ),
                SwitchSection(
                  type: SwitchType.customText,
                  value: notifier.status6,
                  onToggle: (value) => notifier.status6 = value,
                ),
                SwitchSection(
                  type: SwitchType.iconInToggle,
                  value: notifier.status7,
                  onToggle: (value) => notifier.status7 = value,
                ),
                SwitchSection(
                  type: SwitchType.imageAsToggleIcon,
                  value: notifier.status8,
                  onToggle: (value) => notifier.status8 = value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
