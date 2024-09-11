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
import 'domain/option/view/option_layout.dart';

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
      home: const HomeBuilder(),
    );
    ;
  }
}

class HomeBuilder extends ConsumerStatefulWidget {
  const HomeBuilder({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeBuilder> {
  @override
  Widget build(BuildContext context) {
    return const OptionLayout();
  }
}
