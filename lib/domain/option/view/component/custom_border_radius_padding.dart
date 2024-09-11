import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class CustomBorderRadiusPaddingConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const CustomBorderRadiusPaddingConsumer({super.key, required this.onToggle});

  final _optionIndex = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));

    return CustomButtonField(
        status: optionState,
        title: "Custom border radius and padding",
        flutterSwitch: FlutterSwitch(
          width: 125.0,
          height: 55.0,
          valueFontSize: 25.0,
          toggleSize: 45.0,
          value: optionState,
          borderRadius: 30.0,
          padding: 8.0,
          showOnOff: true,
          onToggle: (val) {
            ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          },
        ));
  }
}
//ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
