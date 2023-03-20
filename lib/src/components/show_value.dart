import 'package:flutter/material.dart';

class ShowButtonValue extends StatefulWidget {
  bool statas;

  ShowButtonValue({
    Key? key,
    required this.statas,
  }) : super(key: key);

  @override
  State<ShowButtonValue> createState() => _ShowButtonValueState();
}

class _ShowButtonValueState extends State<ShowButtonValue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        "Value: ${widget.statas}",
      ),
    );
  }
}
