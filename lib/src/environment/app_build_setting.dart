import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/di/configurations.dart';

class AppBuildSetting {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    configureDependencies();
    await getIt.allReady();
  }
}
