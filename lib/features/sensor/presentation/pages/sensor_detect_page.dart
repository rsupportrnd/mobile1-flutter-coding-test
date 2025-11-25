import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/data.dart';

class SensorDetectPage extends StatelessWidget {
  const SensorDetectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SensorRotationRepository sensorRotationRepo =
        context.read<SensorRotationRepository>();

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text("Sensor Detect")),
            body: Center(
              child: GestureDetector(
                  onTap: () => sensorRotationRepo.stream(),
                  child: const Text(
                    "Sensor Stream",
                    style: TextStyle(fontSize: 20),
                  )),
            )));
  }
}
