import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/main_view.dart';
import 'package:rs_flutter_test/util/r_color.dart';
import 'package:rs_flutter_test/viewmodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => MainViewModel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, vm, child) {
        return Theme(
          data: ThemeData(
            textTheme: TextTheme(
              bodyText1: TextStyle(color: vm.textColor),
              bodyText2: TextStyle(color: vm.textColor),
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: vm.bgColor,
              appBar: AppBar(
                backgroundColor: vm.appBarColor,
                title: Text(
                  "FlutterSwitch Demo",
                  style: TextStyle(color: RsupportColor.white_01),
                ),
                actions: [
                  FlutterSwitch(
                    value: context.read<MainViewModel>().isSwitchOn,
                    onToggle: (value) {
                      vm.setSwitchOn(value);
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      defaultView(vm.status1, (isChecked) {
                        vm.setStatus1(isChecked);
                      }),
                      customColorBorderView(vm.status2, (isChecked) {
                        vm.setStatus2(isChecked);
                      }),
                      customTextColorView(vm.status3, (isChecked) {
                        vm.setStatus3(isChecked);
                      }),
                      customSizeView(vm.status4, (isChecked) {
                        vm.setStatus4(isChecked);
                      }),
                      customBorderRadiusPaddingView(vm.status5, (isChecked) {
                        vm.setStatus5(isChecked);
                      }),
                      customTextView(vm.status6, (isChecked) {
                        vm.setStatus6(isChecked);
                      }),
                      iconToggleButtonView(vm.status7, (isChecked) {
                        vm.setStatus7(isChecked);
                      }),
                      iconToggleImageButtonView(vm.status8, (isChecked) {
                        setState(() {
                          vm.setStatus8(isChecked);
                        });
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
