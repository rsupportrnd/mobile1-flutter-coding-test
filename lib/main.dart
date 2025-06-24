import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/environment/app_build_setting.dart';
import 'package:mobile1_flutter_coding_test/src/router/router.dart';

Future<void> main() async {
  await AppBuildSetting.init();

  runApp(const App());
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'RSUPPORT',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      theme: ThemeData(useMaterial3: true),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
