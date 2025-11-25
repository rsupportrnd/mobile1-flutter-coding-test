import 'package:flutter/material.dart';
import '../presentation.dart';

class RazerDisplay extends StatelessWidget {
  const RazerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text("Razer Display")),
            body: const BoxWidget()));
  }
}
