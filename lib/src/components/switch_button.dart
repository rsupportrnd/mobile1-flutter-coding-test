import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum AvatarType { TYPE1 }

class SwitchButton extends StatefulWidget {
  AvatarType type;
  SwitchButton({
    Key? key,
    required this.type,
  }) : super(key: key);

  SwitchButtonState st = new SwitchButtonState();

  void set() {
    st.setSt();
  }

  State<StatefulWidget> createState() => st;
}

class SwitchButtonState extends State<SwitchButton> {
  //기본 state
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  bool status8 = false;
  bool isSwitchOn = false;

  void setSt() {
    setState(() {});
  }

  Widget defualtButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Default"),
        SizedBox(height: 10.0),

        //Button1
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
      ],
    );
  }

  //Switch control
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case AvatarType.TYPE1:
        return defualtButton();
      // case AvatarType.TYPE2:
      //   return type2Widget();
      // case AvatarType.TYPE3:
      //   return type3Widget();
      // case AvatarType.TYPE4:
      //   return type4Widget();

    }
  }
}
