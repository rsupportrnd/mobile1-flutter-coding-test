import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'datasource/local/shared_preferences_switch_repository.dart';
import 'providers/switch_provider.dart';
import 'providers/theme_provider.dart';
import 'show_case_app.dart';
import 'ui/widget/showcase_switch_status_item.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SwitchProvider(
            switchRepository: SharedPreferencesSwitchRepository(),
            keys: ShowCaseSwitchType.values.map((e) => e.name).toList(),
          ),
        ),
        ChangeNotifierProxyProvider<SwitchProvider, ThemeProvider>(
          create: (_) => ThemeProvider(),
          update: (_, switchProvider, themeProvider) {
            final isDarkMode =
                switchProvider.isActive(ShowCaseSwitchType.darkModeSwitch.name);
            if (isDarkMode != themeProvider?.isDarkTheme) {
              themeProvider?.updateTheme(switchProvider
                  .isActive(ShowCaseSwitchType.darkModeSwitch.name));
            }
            return themeProvider ?? ThemeProvider();
          },
        ),
      ],
      child: const ShowCaseApp(),
    ),
  );
}
