import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../core/const/custom_callback.dart';
import '../../../../core/theme/provider/theme_notifier_provider.dart';
import '../../provider/option_list_notifier_provider.dart';
import 'custom_button_field.dart';

class ThemeToggleFieldConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;
  final _optionIndex = 6;

  const ThemeToggleFieldConsumer({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState =
        ref.watch(optionStateListNotifierProvider.select((options) => options[_optionIndex]));
    return CustomButtonField(
      title: "Icon in toggle",
      subTitle: const Text(
        "Inspired by the colors from Github Dark Mode switch",
        style: TextStyle(
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
        ),
      ),
      flutterSwitch: FlutterSwitch(
        width: 100.0,
        height: 55.0,
        toggleSize: 45.0,
        value: optionState,
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
          onToggle(val);
          ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          if (val) {
            /// darkmode
            ref.read(themeNotifierProvider.notifier).toDark();
          } else {
            /// whitemode
            ref.read(themeNotifierProvider.notifier).toWhite();
          }
        },
      ),
    );
  }
}
