import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class ImageAsIconOptionConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const ImageAsIconOptionConsumer({super.key, required this.onToggle});

  final _optionIndex = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));

    return CustomButtonField(
        title: "Image as toggle icon",
        flutterSwitch: FlutterSwitch(
          width: 100.0,
          height: 55.0,
          toggleSize: 45.0,
          value: optionState,
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
          inactiveColor: Color(0xFF54C5F8),
          activeIcon: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
          ),
          inactiveIcon: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
          ),
          onToggle: (val) {
            ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          },
        ));
  }
}
