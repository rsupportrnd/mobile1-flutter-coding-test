import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class CustomColorsBordersOptionConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const CustomColorsBordersOptionConsumer({super.key, required this.onToggle});

  final _optionIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));
    return CustomButtonField(
        status: optionState,
        title: "Custom Colors and Borders",
        flutterSwitch: FlutterSwitch(
          width: 100.0,
          height: 55.0,
          toggleSize: 45.0,
          value: optionState,
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
            onToggle(val);
            ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          },
        ));
  }
}
