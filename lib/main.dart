import 'package:flutter/services.dart';
import 'package:mobile1_flutter_coding_test/local_database/objectbox.dart';
import 'index.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Application());
}
