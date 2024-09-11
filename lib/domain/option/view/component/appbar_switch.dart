import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/domain/option/provider/switch_notifier.dart';
import 'package:rs_flutter_test/main.dart';

import '../../../../core/const/custom_callback.dart';

class AppbarSwitch extends ConsumerWidget {
  BooleanCallback onToggle;

  AppbarSwitch({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionState = ref.watch(switchNotifierProvider);
    return FlutterSwitch(
      value: optionState,
      onToggle: (value) {
        onToggle(value);
        ref.read(switchNotifierProvider.notifier).setSwitch(value);
      },
    );
  }
}
