import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/features/razer/data/data.dart';
import 'package:mobile1_flutter_coding_test/features/razer/presentation/presentation.dart';
import 'package:mobile1_flutter_coding_test/features/sensor/data/data.dart';
import 'package:mobile1_flutter_coding_test/features/sensor/presentation/presentation.dart';
import 'package:provider/provider.dart';

void main() {
  if (Platform.isMacOS) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => RazerPositionRepository())
    ], child: const RazerDisplay()));
  } else if (Platform.isAndroid || Platform.isIOS) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SensorRotationRepository())
    ], child: const SensorDetectPage()));
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('app'));
  }
}
