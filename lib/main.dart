import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/constants/public_elements.dart';
import 'package:rs_flutter_test/screens/home_screen.dart';
import 'package:rs_flutter_test/views/home_view.dart';

void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: StaticColors.primarySwatchColor,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}