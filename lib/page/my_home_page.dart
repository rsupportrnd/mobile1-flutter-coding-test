import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rs_flutter_test/page/local_widget/custom_switch.dart';
import 'package:rs_flutter_test/page/local_widget/default_sized_box.dart';
import 'package:rs_flutter_test/styles/custom_colors.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.onChangeTheme, required this.switchinitials});

  final ValueChanged<ThemeMode> onChangeTheme;
  final List<bool> switchinitials;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("appBarTitle")),
        actions: const [
          CustomSwitch(initialStatus: false),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomSwitch(
                title: tr("switch1"),
                initialStatus: switchinitials[0],
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch2"),
                width: 100.0,
                height: 55.0,
                toggleSize: 45.0,
                initialStatus: switchinitials[1],
                borderRadius: 30.0,
                padding: 2.0,
                toggleColor: CustomColors.firstToggleColor,
                switchBorder: Border.all(
                  color: CustomColors.firstBorderColor,
                  width: 6.0,
                ),
                toggleBorder: Border.all(
                  color: CustomColors.firstBorderColor,
                  width: 5.0,
                ),
                activeColor: CustomColors.firstActiveColor,
                inactiveColor: CustomColors.firstInactiveColor,
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch3"),
                initialStatus: switchinitials[2],
                showOnOff: true,
                activeTextColor: CustomColors.firstActiveTextColor,
                inactiveTextColor: CustomColors.firstInactiveTextColor,
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch4"),
                initialStatus: switchinitials[3],
                width: 55.0,
                height: 25.0,
                toggleSize: 18.0,
                valueFontSize: 12.0,
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch5"),
                initialStatus: switchinitials[4],
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch6.title"),
                initialStatus: switchinitials[5],
                activeText: tr("switch6.activeText"),
                inactiveText: tr("switch6.inactiveText"),
                valueFontSize: 10.0,
                width: 110,
                borderRadius: 30.0,
                showOnOff: true,
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch7.title"),
                subTitle: tr("switch7.subTitle"),
                initialStatus: switchinitials[6],
                width: 100.0,
                height: 55.0,
                toggleSize: 45.0,
                borderRadius: 30.0,
                padding: 2.0,
                activeToggleColor: CustomColors.firstActiveToggleColor,
                inactiveToggleColor: CustomColors.firstInactiveToggleColor,
                activeSwitchBorder: Border.all(
                  color: CustomColors.firstActiveBorderColor,
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: CustomColors.firstInactiveBorderColor,
                  width: 6.0,
                ),
                activeColor: CustomColors.secondActiveColor,
                inactiveColor: CustomColors.secondInactiveColor,
                activeIcon: const Icon(
                  Icons.nightlight_round,
                  color: CustomColors.moonIconColor,
                ),
                inactiveIcon: const Icon(
                  Icons.wb_sunny,
                  color: CustomColors.sunIconColor,
                ),
                onToggle: (val) {
                  onChangeTheme(val ? ThemeMode.dark : ThemeMode.light);
                },
              ),
              defaultHeightSizedBox,
              CustomSwitch(
                title: tr("switch8"),
                initialStatus: switchinitials[7],
                width: 100.0,
                height: 55.0,
                toggleSize: 45.0,
                borderRadius: 30.0,
                padding: 2.0,
                activeToggleColor: CustomColors.secondActiveToggleColor,
                inactiveToggleColor: CustomColors.secondInactiveToggleColor,
                activeSwitchBorder: Border.all(
                  color: CustomColors.secondActiveBorderColor,
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: CustomColors.secondInactiveBorderColor,
                  width: 6.0,
                ),
                activeColor: CustomColors.thirdActiveColor,
                inactiveColor: CustomColors.thirdInactiveColor,
                activeIcon: Image.asset(tr("assetPath")),
                inactiveIcon: Image.network(tr("urlPath")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
