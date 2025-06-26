import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///앱 시작 시 필요한 설정들
class AppBuildSetting {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
