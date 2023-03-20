import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'ui/page/switch_showcase_page.dart';

class ShowCaseApp extends StatelessWidget {
  const ShowCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.currentTheme,
      home: const SwitchShowCasePage(),
    );
  }
}
