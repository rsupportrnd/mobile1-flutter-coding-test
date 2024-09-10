import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rs_flutter_test/core/theme/provider/theme_notifier_provider.dart';
import 'package:rs_flutter_test/domain/option/view/component/custom_button_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: ThemeBuilder());
  }
}

class ThemeBuilder extends ConsumerWidget {
  const ThemeBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      theme: theme,
      home: MyHomePage(),
    );
    ;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FlutterSwitch Demo",
          style: TextStyle(color: Colors.white),
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomButtonField(
                title: "Default",
                flutterSwitch: FlutterSwitch(
                    value: status1,
                    onToggle: (val) {
                      setState(() {
                        status1 = val;
                      });
                    }),
              ),
              const SizedBox(height: 20.0),
              CustomButtonField(
                  title: "Custom Colors and Borders",
                  flutterSwitch: FlutterSwitch(
                    width: 100.0,
                    height: 55.0,
                    toggleSize: 45.0,
                    value: status2,
                    borderRadius: 30.0,
                    padding: 2.0,
                    toggleColor: const Color.fromRGBO(225, 225, 225, 1),
                    switchBorder: Border.all(
                      color: const Color.fromRGBO(2, 107, 206, 1),
                      width: 6.0,
                    ),
                    toggleBorder: Border.all(
                      color: const Color.fromRGBO(2, 107, 206, 1),
                      width: 5.0,
                    ),
                    activeColor: const Color.fromRGBO(51, 226, 255, 1),
                    inactiveColor: Colors.black38,
                    onToggle: (val) {
                      setState(() {
                        status2 = val;
                      });
                    },
                  )),
              const SizedBox(height: 20.0),
              CustomButtonField(
                  title: "With 'On' and 'Off' text and custom text colors",
                  flutterSwitch: FlutterSwitch(
                    showOnOff: true,
                    activeTextColor: Colors.black,
                    inactiveTextColor: Colors.blue[50]!,
                    value: status3,
                    onToggle: (val) {
                      setState(() {
                        status3 = val;
                      });
                    },
                  )),
              const SizedBox(height: 20.0),
              CustomButtonField(
                title: "Custom size",
                flutterSwitch: FlutterSwitch(
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
              ),
              const SizedBox(height: 20.0),
              CustomButtonField(
                  title: "Custom border radius and padding",
                  flutterSwitch: FlutterSwitch(
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
                  )),
              const SizedBox(height: 20.0),
              CustomButtonField(
                  title: "Custom text",
                  flutterSwitch: FlutterSwitch(
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
                  )),
              const SizedBox(height: 20.0),
              ThemeToggleField(
                  toggleStatus: status7,
                  onToggleWidget: (val) {
                    setState(() {
                      status7 = val;
                    });
                  }),
              const SizedBox(height: 20.0),
              CustomButtonField(
                  title: "Image as toggle icon",
                  flutterSwitch: FlutterSwitch(
                    width: 100.0,
                    height: 55.0,
                    toggleSize: 45.0,
                    value: status8,
                    borderRadius: 30.0,
                    padding: 2.0,
                    activeToggleColor: Color(0xFF0082C8),
                    inactiveToggleColor: Color(0xFF01579B),
                    activeSwitchBorder: Border.all(
                      color: Color(0xFF00D2B8),
                      width: 6.0,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: Color(0xFF29B6F6),
                      width: 6.0,
                    ),
                    activeColor: Color(0xFF55DDCA),
                    inactiveColor: Color(0xFF54C5F8),
                    activeIcon: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                    ),
                    inactiveIcon: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                    ),
                    onToggle: (val) {
                      setState(() {
                        status8 = val;
                      });
                    },
                  )),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

typedef BooleanCallback = Function(bool val);

class ThemeToggleField extends ConsumerStatefulWidget {
  final bool toggleStatus;
  final BooleanCallback onToggleWidget;

  const ThemeToggleField({super.key, required this.toggleStatus, required this.onToggleWidget});

  @override
  ConsumerState createState() => _ThemeToggleFieldState();
}

class _ThemeToggleFieldState extends ConsumerState<ThemeToggleField> {
  @override
  Widget build(BuildContext context) {
    return CustomButtonField(
      title: "Icon in toggle",
      subTitle: const Text(
        "Inspired by the colors from Github Dark Mode switch",
        style: TextStyle(
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
        ),
      ),
      flutterSwitch: FlutterSwitch(
        width: 100.0,
        height: 55.0,
        toggleSize: 45.0,
        value: widget.toggleStatus,
        borderRadius: 30.0,
        padding: 2.0,
        activeToggleColor: Color(0xFF6E40C9),
        inactiveToggleColor: Color(0xFF2F363D),
        activeSwitchBorder: Border.all(
          color: Color(0xFF3C1E70),
          width: 6.0,
        ),
        inactiveSwitchBorder: Border.all(
          color: Color(0xFFD1D5DA),
          width: 6.0,
        ),
        activeColor: Color(0xFF271052),
        inactiveColor: Colors.white,
        activeIcon: const Icon(
          Icons.nightlight_round,
          color: Color(0xFFF8E3A1),
        ),
        inactiveIcon: const Icon(
          Icons.wb_sunny,
          color: Color(0xFFFFDF5D),
        ),
        onToggle: (val) {
          setState(() {
            widget.onToggleWidget(val);
            if (val) {
              /// darkmode
              ref.read(themeNotifierProvider.notifier).toDark();
            } else {
              /// whitemode
              ref.read(themeNotifierProvider.notifier).toWhite();
            }
          });
        },
      ),
    );
  }
}
