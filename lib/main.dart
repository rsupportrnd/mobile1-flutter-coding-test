import 'package:flutter/services.dart';

import 'index.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Application());
}
