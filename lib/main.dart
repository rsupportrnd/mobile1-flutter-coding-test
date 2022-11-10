import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/src/provider/switch_provider.dart';
import 'package:rs_flutter_test/src/ui/home_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => SwitchProvider(),
        child: const Home(),
      ),
    );
  }
}
