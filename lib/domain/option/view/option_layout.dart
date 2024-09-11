import 'package:flutter/material.dart';

import 'component/appbar_switch.dart';
import 'component/custom_border_radius_padding.dart';
import 'component/custom_colors_borders_option.dart';
import 'component/custom_size_option.dart';
import 'component/custom_text_option.dart';
import 'component/default_option.dart';
import 'component/image_as_icon_option.dart';
import 'component/text_on_off_option.dart';
import 'component/theme_option.dart';

class OptionLayout extends StatelessWidget {
  const OptionLayout({super.key});

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
