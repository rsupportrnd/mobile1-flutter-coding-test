import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class TextOnOffOptionConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const TextOnOffOptionConsumer({super.key, required this.onToggle});

  final _optionIndex = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));
    return CustomButtonField(
        title: "With 'On' and 'Off' text and custom text colors",
        flutterSwitch: FlutterSwitch(
          showOnOff: true,
          activeTextColor: Colors.black,
          inactiveTextColor: Colors.blue[50]!,
          value: optionState,
          onToggle: (val) {
            onToggle(val);
            ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          },
        ));
  }
}
