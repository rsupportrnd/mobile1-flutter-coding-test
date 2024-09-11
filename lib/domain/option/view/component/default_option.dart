import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';

import '../../../../core/const/custom_callback.dart';
import 'custom_button_field.dart';

class DefaultOptionConsumer extends ConsumerWidget {
  final BooleanCallback onToggle;

  const DefaultOptionConsumer({super.key, required this.onToggle});

  final _optionIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(optionStateListNotifierProvider.select(
      (value) => value[_optionIndex],
    ));
    print(optionState);
    print("toggle optionState");
    return CustomButtonField(
      title: "Default",
      flutterSwitch: FlutterSwitch(
          value: optionState,
          onToggle: (val) {
            onToggle(val);
            print("val $val");
            ref.read(optionStateListNotifierProvider.notifier).setOptionAtIndex(_optionIndex, val);
          }),
    );
  }
}
