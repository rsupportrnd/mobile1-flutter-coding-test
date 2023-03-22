import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/config/color.dart';
import 'package:rs_flutter_test/config/constant.dart';
import 'package:rs_flutter_test/controller/theme_controller.dart';
import 'package:rs_flutter_test/presentation/view_model/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (
          BuildContext context,
          HomeViewModel homeViewModel,
          Widget? child,
        ) =>
            Scaffold(
          appBar: AppBar(
            title: const Text(
              "FlutterSwitch Demo",
              style: TextStyle(color: AppColors.white),
            ),
            actions: [
              FlutterSwitch(
                value: homeViewModel.isSwitchOn,
                onToggle: homeViewModel.toggleSwitch,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Default"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        value: homeViewModel.status1,
                        onToggle: homeViewModel.toggleStatus1,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${homeViewModel.status1}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom Colors and Borders"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: homeViewModel.status2,
                        borderRadius: 30.0,
                        padding: 2.0,
                        toggleColor: AppColors.lightGray,
                        switchBorder: Border.all(
                          color: AppColors.blueAccent,
                          width: 6.0,
                        ),
                        toggleBorder: Border.all(
                          color: AppColors.blueAccent,
                          width: 5.0,
                        ),
                        activeColor: AppColors.lightSkyBlue,
                        inactiveColor: AppColors.darkGray,
                        onToggle: homeViewModel.toggleStatus2,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${homeViewModel.status2}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("With 'On' and 'Off' text and custom text colors"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        showOnOff: true,
                        activeTextColor: AppColors.black,
                        inactiveTextColor: AppColors.whiteBlue,
                        value: homeViewModel.status3,
                        onToggle: homeViewModel.toggleStatus3,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${homeViewModel.status3}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom size"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 55.0,
                        height: 25.0,
                        valueFontSize: 12.0,
                        toggleSize: 18.0,
                        value: homeViewModel.status4,
                        onToggle: homeViewModel.toggleStatus4,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${homeViewModel.status4}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom border radius and padding"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 125.0,
                        height: 55.0,
                        valueFontSize: 25.0,
                        toggleSize: 45.0,
                        value: homeViewModel.status5,
                        borderRadius: 30.0,
                        padding: 8.0,
                        showOnOff: true,
                        onToggle: homeViewModel.toggleStatus5,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${homeViewModel.status5}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Custom text"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        activeText: "All Good. Negative.",
                        inactiveText: "Under Quarantine.",
                        value: homeViewModel.status6,
                        valueFontSize: 10.0,
                        width: 110,
                        borderRadius: 30.0,
                        showOnOff: true,
                        onToggle: homeViewModel.toggleStatus6,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Value: ${homeViewModel.status6}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Icon in toggle"),
                  const Text(
                    "Inspired by the colors from Github Dark Mode switch",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: homeViewModel.status7,
                        borderRadius: 30.0,
                        padding: 2.0,
                        activeToggleColor: AppColors.lightPurple,
                        inactiveToggleColor: AppColors.blueGray1,
                        activeSwitchBorder: Border.all(
                          color: AppColors.purple,
                          width: 6.0,
                        ),
                        inactiveSwitchBorder: Border.all(
                          color: AppColors.gray,
                          width: 6.0,
                        ),
                        activeColor: AppColors.darkPurple,
                        inactiveColor: AppColors.white,
                        activeIcon: const Icon(
                          Icons.nightlight_round,
                          color: AppColors.lightYellow,
                        ),
                        inactiveIcon: const Icon(
                          Icons.wb_sunny,
                          color: AppColors.yellow,
                        ),
                        onToggle: (val) {
                          homeViewModel.toggleStatus7(val);
                          context.read<ThemeController>().toggleDarkMode();
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text("Value: ${homeViewModel.status7}"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Image as toggle icon"),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        width: 100.0,
                        height: 55.0,
                        toggleSize: 45.0,
                        value: homeViewModel.status8,
                        borderRadius: 30.0,
                        padding: 2.0,
                        activeToggleColor: AppColors.sapphire,
                        inactiveToggleColor: AppColors.cobalt,
                        activeSwitchBorder: Border.all(
                          color: AppColors.mint,
                          width: 6.0,
                        ),
                        inactiveSwitchBorder: Border.all(
                          color: AppColors.darkSkyBlue,
                          width: 6.0,
                        ),
                        activeColor: AppColors.lightMint,
                        inactiveColor: AppColors.skyBlue,
                        activeIcon: Image.network(
                          flutterCommunityLogo,
                        ),
                        inactiveIcon: Image.network(
                          dartLogo,
                        ),
                        onToggle: homeViewModel.toggleStatus8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text("Value: ${homeViewModel.status8}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
