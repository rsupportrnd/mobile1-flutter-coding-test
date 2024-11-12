import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/common.dart';
import 'layers/presentation/main/main_frame_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MultiProvider(
        providers: [
        ],
        child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: const MainFrameView(),
    );
  }
}
