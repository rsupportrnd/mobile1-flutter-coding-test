import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/switch_provider.dart';
import '../widget/showcase_switch_status_item.dart';

class SwitchShowCasePage extends StatelessWidget {
  final title = 'FlutterSwitch Demo';
  const SwitchShowCasePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: [
          Consumer<SwitchProvider>(
            builder: (context, switchProvider, _) => FlutterSwitch(
              value: switchProvider
                  .isActive(ShowCaseSwitchType.appBarActionSwitch.name),
              onToggle: (val) {
                switchProvider
                    .toggleSwitch(ShowCaseSwitchType.appBarActionSwitch.name);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ShowCaseSwitchStatusItem.create(ShowCaseSwitchType.defaultSwitch),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(
                  ShowCaseSwitchType.customColorsAndBorders),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(
                  ShowCaseSwitchType.withTextCustomColor),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(ShowCaseSwitchType.customSize),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(
                  ShowCaseSwitchType.customBorderRadiusAndPadding),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(ShowCaseSwitchType.customText),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(
                  ShowCaseSwitchType.darkModeSwitch),
              const SizedBox(height: 20.0),
              ShowCaseSwitchStatusItem.create(
                  ShowCaseSwitchType.imageAsToggleIcon),
            ],
          ),
        ),
      ),
    );
  }
}
