import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_viewmodel.dart';
import 'package:provider/provider.dart';

import 'common/common.dart';
import 'layers/presentation/main/main_frame_view.dart';
import 'layers/presentation/main/main_frame_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the locator
  initLocator();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> MainFrameViewModel()),
          ChangeNotifierProvider(create: (_)=> UserListViewModel()),
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
