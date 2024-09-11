import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class CustomSizeOptionConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const CustomSizeOptionConsumer({super.key, required this.onToggle});

  final _optionIndex = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));

    return CustomButtonField(
      title: "Custom size",
      flutterSwitch: FlutterSwitch(
        width: 55.0,
        height: 25.0,
        valueFontSize: 12.0,
        toggleSize: 18.0,
        value: optionState,
        onToggle: (val) {
          ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
        },
      ),
    );
  }
}
