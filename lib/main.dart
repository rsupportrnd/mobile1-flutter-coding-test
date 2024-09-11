import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/core/theme/provider/theme_notifier_provider.dart';
import 'package:rs_flutter_test/domain/option/provider/option_list_notifier_provider.dart';
import 'package:rs_flutter_test/domain/option/view/component/custom_border_radius_padding.dart';
import 'package:rs_flutter_test/domain/option/view/component/custom_button_field.dart';
import 'package:rs_flutter_test/domain/option/view/component/appbar_switch.dart';
import 'package:rs_flutter_test/domain/option/view/component/custom_colors_borders_option.dart';
import 'package:rs_flutter_test/domain/option/view/component/custom_size_option.dart';
import 'package:rs_flutter_test/domain/option/view/component/custom_text_option.dart';
import 'package:rs_flutter_test/domain/option/view/component/default_option.dart';
import 'package:rs_flutter_test/domain/option/view/component/text_on_off_option.dart';

import 'domain/option/view/component/image_as_icon_option.dart';
import 'domain/option/view/component/theme_option.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: ThemeBuilder());
  }
}

class ThemeBuilder extends ConsumerWidget {
  const ThemeBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      theme: theme,
      home: MyHomePage(),
    );
    ;
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  bool status8 = false;
  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FlutterSwitch Demo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          AppbarSwitch(
            onToggle: (value) {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DefaultOptionConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              CustomColorsBordersOptionConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              TextOnOffOptionConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              CustomSizeOptionConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              CustomBorderRadiusPaddingConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              CustomTextOptionConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              ThemeToggleFieldConsumer(onToggle: (val) {}),
              const SizedBox(height: 20.0),
              ImageAsIconOptionConsumer(onToggle: (val) {}),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
