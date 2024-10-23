import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/custom_switch.dart';
import '../../widgets/colum_with_space.dart';
import '../../custom_theme.dart';
import 'switch_demo_item.dart';

class SwitchDemoPage extends HookConsumerWidget {
  SwitchDemoPage({super.key, required this.themeMode});

  final CustomThemeMode themeMode;

  final _initialValues = [
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSwitchOn = useState(false);
    return Scaffold(
      backgroundColor: themeMode.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeMode.appBarColor,
        title: const Text(
          "FlutterSwitch Demo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          CustomSwitch.defaultSwitch(
            value: isSwitchOn.value,
            onToggle: (value) {
              isSwitchOn.value = value;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ColumnWithSpace(
              space: 20.0,
              children: CustomSwitchType.values.mapIndexed((index, type) => SwitchDemoItem(
                type: type,
                initialValue: _initialValues[index],
                onToggled: (value) => onToggled(ref, type, value),
              )).toList(),
            )),
      ),
    );
  }

  void onToggled(WidgetRef ref, CustomSwitchType type, bool value) => type ==
          CustomSwitchType.iconInToggle
      ? ref.read(customThemeProvider.notifier).setThemeMode(isDarkMode: value)
      : null;
}
