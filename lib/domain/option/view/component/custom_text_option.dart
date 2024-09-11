import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class CustomTextOptionConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const CustomTextOptionConsumer({super.key, required this.onToggle});

  final _optionIndex = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));

    return CustomButtonField(
        title: "Custom text",
        flutterSwitch: FlutterSwitch(
          activeText: "All Good. Negative.",
          inactiveText: "Under Quarantine.",
          value: optionState,
          valueFontSize: 10.0,
          width: 110,
          borderRadius: 30.0,
          showOnOff: true,
          onToggle: (val) {
            ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          },
        ));
  }
}
