import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/views/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Color textColor;
  late Color scaffoldBgColor;

  @override
  Widget build(BuildContext context) {

    textColor = context.watch<ThemeProvider>().textColor;
    scaffoldBgColor = context.watch<ThemeProvider>().scaffoldBgColor;

    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: textColor),
          bodyText2: TextStyle(color: textColor),
        ),
      ),
      child: Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: AppbarSection(),
        body: const SafeArea(
          child: SwitchSection(),
        ),
      ),
    );
  }
}