import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';

typedef BooleanCallback = Function(bool value);

class CustomButtonField extends StatefulWidget {
  final String title;
  final FlutterSwitch flutterSwitch;
  final Text? subTitle;

  const CustomButtonField(
      {super.key, required this.title, required this.flutterSwitch, this.subTitle});

  @override
  State<CustomButtonField> createState() => _CustomButtonFieldState();
}

class _CustomButtonFieldState extends State<CustomButtonField> {
  bool _state = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        if (widget.subTitle != null) widget.subTitle!,
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.flutterSwitch,
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Value: $_state",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// FlutterSwitch(
// width: 100.0,
// height: 55.0,
// toggleSize: 45.0,
// value: status2,
// borderRadius: 30.0,
// padding: 2.0,
// toggleColor: Color.fromRGBO(225, 225, 225, 1),
// switchBorder: Border.all(
// color: Color.fromRGBO(2, 107, 206, 1),
// width: 6.0,
// ),
// toggleBorder: Border.all(
// color: Color.fromRGBO(2, 107, 206, 1),
// width: 5.0,
// ),
// activeColor: Color.fromRGBO(51, 226, 255, 1),
// inactiveColor: Colors.black38,
// onToggle: (val) {
// setState(() {
// status2 = val;
// });
// },
// ),
