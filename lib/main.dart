import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/util/r_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  bool status8 = false;
  bool isSwitchOn = false;

  Color _textColor = RsupportColor.black_01;
  Color _appBarColor = RsupportColor.appBarColor;
  Color _scaffoldBgcolor = RsupportColor.white_01;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: _textColor),
          bodyText2: TextStyle(color: _textColor),
        ),
      ),
      child: Scaffold(
        backgroundColor: _scaffoldBgcolor,
        appBar: AppBar(
          backgroundColor: _appBarColor,
          title: Text(
            "FlutterSwitch Demo",
            style: TextStyle(color: RsupportColor.white_01),
          ),
          actions: [
            FlutterSwitch(
              value: isSwitchOn,
              onToggle: (value) {
                setState(() {
                  isSwitchOn = value;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Default"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      value: status1,
                      onToggle: (val) {
                        setState(() {
                          status1 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status1",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Custom Colors and Borders"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status2,
                      borderRadius: 30.0,
                      padding: 2.0,
                      toggleColor: RsupportColor.white_02,
                      switchBorder: Border.all(
                        color: RsupportColor.blue_01,
                        width: 6.0,
                      ),
                      toggleBorder: Border.all(
                        color: RsupportColor.blue_01,
                        width: 5.0,
                      ),
                      activeColor: RsupportColor.blue_02,
                      inactiveColor: RsupportColor.black_05,
                      onToggle: (val) {
                        setState(() {
                          status2 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status2",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("With 'On' and 'Off' text and custom text colors"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      showOnOff: true,
                      activeTextColor: RsupportColor.black_01,
                      inactiveTextColor: Colors.blue[50]!,
                      value: status3,
                      onToggle: (val) {
                        setState(() {
                          status3 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status3",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Custom size"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 55.0,
                      height: 25.0,
                      valueFontSize: 12.0,
                      toggleSize: 18.0,
                      value: status4,
                      onToggle: (val) {
                        setState(() {
                          status4 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status4",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Custom border radius and padding"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 125.0,
                      height: 55.0,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: status5,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status5 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status5",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Custom text"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      activeText: "All Good. Negative.",
                      inactiveText: "Under Quarantine.",
                      value: status6,
                      valueFontSize: 10.0,
                      width: 110,
                      borderRadius: 30.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status6 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status6",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Icon in toggle"),
                Text(
                  "Inspired by the colors from Github Dark Mode switch",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status7,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: RsupportColor.purple_01,
                      inactiveToggleColor: RsupportColor.blue_03,
                      activeSwitchBorder: Border.all(
                        color: RsupportColor.purple_02,
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: RsupportColor.white_03,
                        width: 6.0,
                      ),
                      activeColor: RsupportColor.purple_03,
                      inactiveColor: RsupportColor.white_01,
                      activeIcon: Icon(
                        Icons.nightlight_round,
                        color: RsupportColor.yellow_02,
                      ),
                      inactiveIcon: Icon(
                        Icons.wb_sunny,
                        color: RsupportColor.yellow_01,
                      ),
                      onToggle: (val) {
                        setState(() {
                          status7 = val;

                          if (val) {
                            _textColor = RsupportColor.white_01;
                            _appBarColor = RsupportColor.black_02;
                            _scaffoldBgcolor = RsupportColor.black_04;
                          } else {
                            _textColor = RsupportColor.black_01;
                            _appBarColor = RsupportColor.black_03;
                            _scaffoldBgcolor = RsupportColor.white_01;
                          }
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text("Value: $status7"),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Image as toggle icon"),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status8,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: RsupportColor.blue_04,
                      inactiveToggleColor: RsupportColor.blue_05,
                      activeSwitchBorder: Border.all(
                        color: RsupportColor.blue_05,
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: RsupportColor.blue_06,
                        width: 6.0,
                      ),
                      activeColor: RsupportColor.blue_07,
                      inactiveColor: RsupportColor.blue_08,
                      activeIcon: Image.network(
                        "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png",
                      ),
                      inactiveIcon: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                      ),
                      onToggle: (val) {
                        setState(() {
                          status8 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text("Value: $status8"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
