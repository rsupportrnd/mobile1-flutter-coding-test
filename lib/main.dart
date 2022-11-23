import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/l10n/L10n.dart';
import 'package:rs_flutter_test/util/r_color.dart';

import 'main_ex.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
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
  late AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context)!;

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
                  localization.title,
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
                      defaultView(localization.customTitle01, vm.status1,
                          (isChecked) {
                        vm.setStatus1(isChecked);
                      }),
                      customColorBorderView(
                          localization.customTitle02, vm.status2, (isChecked) {
                        vm.setStatus2(isChecked);
                      }),
                      customTextColorView(
                          localization.customTitle03, vm.status3, (isChecked) {
                        vm.setStatus3(isChecked);
                      }),
                      customSizeView(localization.customTitle04, vm.status4,
                          (isChecked) {
                        vm.setStatus4(isChecked);
                      }),
                      customBorderRadiusPaddingView(
                          localization.customTitle05, vm.status5, (isChecked) {
                        vm.setStatus5(isChecked);
                      }),
                      customTextView(localization.customTitle05, vm.status6,
                          (isChecked) {
                        vm.setStatus6(isChecked);
                      }),
                      iconToggleButtonView(
                          localization.customToggleTitle01,
                          localization.customToggleTitle01Sub,
                          vm.status7, (isChecked) {
                        vm.setStatus7(isChecked);
                      }),
                      iconToggleImageButtonView(
                          localization.customToggleTitle02,
                          vm.status8,
                          vm.activeIconUrl,
                          vm.inActiveIconUrl, (isChecked) {
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
