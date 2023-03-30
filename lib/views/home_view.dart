import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/constants/public_elements.dart';
import 'package:rs_flutter_test/screens/home_screen.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AppbarSection extends AppBar {
  AppbarSection({super.key});

  @override
  State<AppbarSection> createState() => _AppbarSectionState();
}

class _AppbarSectionState extends State<AppbarSection> {

  late bool isSwitchOn;
  late Color appbarColor;

  @override
  void initState() {
    isSwitchOn = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    appbarColor = context.watch<ThemeProvider>().appbarColor;

    return AppBar(
      backgroundColor: appbarColor,
      title: const Text("FlutterSwitch Demo", style: TextStyle(color: Colors.white)),
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
    );
  }

  void changeTheme(bool? state) {
    context.read<ThemeProvider>().changeTheme(state!);
  }
}

class SwitchSection extends StatefulWidget {
  const SwitchSection({Key? key}) : super(key: key);

  @override
  State<SwitchSection> createState() => _SwitchSectionState();
}

class _SwitchSectionState extends State<SwitchSection> {

  late List<Widget> switchList;

  void changeTheme(bool state) {
    context.read<ThemeProvider>().changeTheme(state);
  }

  @override
  void initState() {
    var firstSwitch = SwitchPanel(switchTitle: 'Default');
    var secondSwitch = SwitchPanel(
      switchTitle: 'Custom Colors and Borders',
      defaultValue: true,
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      padding: 2.0,
      toggleColor: StaticColors.secondToggleColor,
      switchBorder: Border.all(color: StaticColors.secondSwitchBorderColor, width: 6.0),
      toggleBorder: Border.all(color: StaticColors.secondSwitchBorderColor, width: 5.0),
      activeColor: StaticColors.secondActiveColor,
      inactiveColor: StaticColors.secondInactiveColor,
    );
    var thirdSwitch = SwitchPanel(
      switchTitle: "With 'On' and 'Off' text and custom text colors",
      showOnOff: true,
      activeTextColor: StaticColors.thirdActiveTextColor,
      inactiveTextColor: StaticColors.thirdInactiveTextColor,
    );
    var fourthSwitch = SwitchPanel(
      switchTitle: 'Custom size',
      width: 55.0,
      height: 25.0,
      valueFontSize: 12.0,
      toggleSize: 18.0,
    );
    var fifthSwitch = SwitchPanel(
      switchTitle: 'Custom border radius and padding',
      width: 125.0,
      height: 55.0,
      valueFontSize: 25.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      padding: 8.0,
      showOnOff: true,
    );
    var sixthSwitch = SwitchPanel(
      switchTitle: 'Custom text',
      activeText: 'All Good. Negative.',
      inactiveText: 'Under Quarantine.',
      valueFontSize: 10.0,
      width: 110,
      borderRadius: 30.0,
      showOnOff: true,
    );
    var seventhSwitch = SwitchPanel(
      switchTitle: 'Icon in toggle',
      switchSubTitle: 'Inspired by the colors from Github Dark Mode switch',
      changeTheme: changeTheme,
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: StaticColors.seventhActiveToggleColor,
      inactiveToggleColor: StaticColors.seventhInactiveToggleColor,
      activeSwitchBorder: Border.all(color: StaticColors.seventhActiveSwitchBorderColor, width: 6.0),
      inactiveSwitchBorder: Border.all(color: StaticColors.seventhInactiveSwitchBorderColor, width: 6.0),
      activeColor: StaticColors.seventhActiveColor,
      inactiveColor: StaticColors.seventhInactiveColor,
      activeIcon: Icon(Icons.nightlight_round, color: StaticColors.seventhActiveIconColor),
      inactiveIcon: Icon(Icons.wb_sunny, color: StaticColors.seventhInactiveIconColor),
    );
    var eighthSwitch = SwitchPanel(
      switchTitle: 'Image as toggle icon',
      width: 100.0,
      height: 55.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: StaticColors.eighthActiveToggleColor,
      inactiveToggleColor: StaticColors.eighthInactiveToggleColor,
      activeSwitchBorder: Border.all(color: StaticColors.eighthActiveSwitchBorderColor, width: 6.0),
      inactiveSwitchBorder: Border.all(color: StaticColors.eighthInactiveSwitchBorderColor, width: 6.0),
      activeColor: StaticColors.eighthActiveColor,
      inactiveColor: StaticColors.eighthInactiveColor,
      activeIcon: Image.network(
        "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png",
      ),
      inactiveIcon: Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
      ),
    );

    switchList = [
      firstSwitch,
      secondSwitch,
      thirdSwitch,
      fourthSwitch,
      fifthSwitch,
      sixthSwitch,
      seventhSwitch,
      eighthSwitch,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            children: switchList
        ),
      ),
    );
  }
}

class SwitchPanel extends StatefulWidget {
  Function? changeTheme;
  String? switchTitle;
  String? switchSubTitle;
  bool? defaultValue;
  double? width;
  double? height;
  double? valueFontSize;
  double? toggleSize;
  double? borderRadius;
  double? padding;
  Color? toggleColor;
  BoxBorder? switchBorder;
  BoxBorder? toggleBorder;
  Color? activeColor;
  Color? inactiveColor;
  bool? showOnOff;
  String? activeText;
  String? inactiveText;
  Color? activeTextColor;
  Color? inactiveTextColor;
  Color? activeToggleColor ;
  Color? inactiveToggleColor;
  BoxBorder? activeSwitchBorder;
  BoxBorder? inactiveSwitchBorder;
  Widget? activeIcon;
  Widget? inactiveIcon;

  SwitchPanel({
    Key? key,
    this.changeTheme,
    this.switchTitle,
    this.switchSubTitle,
    this.defaultValue,
    this.width,
    this.height,
    this.valueFontSize,
    this.toggleSize,
    this.borderRadius,
    this.padding,
    this.toggleColor,
    this.switchBorder,
    this.toggleBorder,
    this.activeColor,
    this.inactiveColor,
    this.showOnOff,
    this.activeText,
    this.inactiveText,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.activeIcon,
    this.inactiveIcon
  }) : super(key: key);

  @override
  State<SwitchPanel> createState() => _SwitchPanelState();
}

class _SwitchPanelState extends State<SwitchPanel> {

  late bool toggleState;

  @override
  void initState() {
    toggleState = widget.defaultValue ?? false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // widget.isAppbarElement == true ? const SizedBox.shrink() :
          Text(widget.switchTitle ?? ''),
          // widget.isAppbarElement == true ? const SizedBox.shrink() :
          Text(widget.switchSubTitle ?? '', style: const TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,),),
          const SizedBox(height: 10.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlutterSwitch(
                  width: widget.width ?? 70.0,
                  height: widget.height ?? 35.0,
                  valueFontSize: widget.valueFontSize ?? 16.0,
                  toggleSize: widget.toggleSize ?? 25.0,
                  value: toggleState,
                  borderRadius: widget.borderRadius ?? 20.0,
                  padding: widget.padding ?? 4.0,
                  toggleColor: widget.toggleColor ?? Colors.white,
                  switchBorder: widget.switchBorder,
                  toggleBorder: widget.toggleBorder,
                  activeColor: widget.activeColor ?? Colors.blue,
                  inactiveColor: widget.inactiveColor ?? Colors.grey,
                  showOnOff: widget.showOnOff ?? false,
                  activeText: widget.showOnOff == true ? (widget.activeText ?? 'On') : '',
                  inactiveText: widget.showOnOff == true ? (widget.inactiveText ?? 'Off') : '',
                  activeTextColor: widget.activeTextColor ?? Colors.white70,
                  inactiveTextColor: widget.inactiveTextColor ?? Colors.white70,
                  activeToggleColor: widget.activeToggleColor ?? widget.toggleColor,
                  inactiveToggleColor: widget.inactiveToggleColor ?? widget.toggleColor,
                  activeSwitchBorder: widget.activeSwitchBorder,
                  inactiveSwitchBorder: widget.inactiveSwitchBorder,
                  activeIcon: widget.activeIcon,
                  inactiveIcon: widget.inactiveIcon,
                  onToggle: (val) {
                    setState(() {
                      toggleState = val;
                      widget.changeTheme == null ? {} : widget.changeTheme!.call(val);
                    });
                  },
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text('value: $toggleState')),
              ]
          ),
          const SizedBox(
              height: 20.0
          )
        ]
    );
  }
}

class ThemeProvider with ChangeNotifier {
  Color _textColor = StaticColors.textColor;
  Color get textColor => _textColor;
  Color _appbarColor = StaticColors.appBarColor;
  Color get appbarColor => _appbarColor;
  Color _scaffoldBgColor = StaticColors.scaffoldColor;
  Color get scaffoldBgColor => _scaffoldBgColor;

  void changeTheme(bool state) {
    if(state == true) {
      _textColor = StaticColors.darkThemeTextColor;
      _appbarColor = StaticColors.darkThemeAppbarColor;
      _scaffoldBgColor = StaticColors.darkThemeScaffoldBgColor;
    } else if(state == false) {
      _textColor = StaticColors.lightThemeTextColor;
      _appbarColor = StaticColors.lightThemeAppbarColor;
      _scaffoldBgColor = StaticColors.lightThemeScaffoldBgColor;
    }
    notifyListeners();
  }
}