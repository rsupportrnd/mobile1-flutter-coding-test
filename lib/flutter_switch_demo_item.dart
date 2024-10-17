import 'package:flutter/material.dart';

class FlutterSwitchDemoItem extends StatelessWidget {
const FlutterSwitchDemoItem({super.key, required this.title, this.description, required this.value, required this.flutterSwitch});

final String title;
final String? description;
final bool value;
final Widget flutterSwitch;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title),
          Visibility(
            visible: description != null,
            child: Text(
              description ?? "",
              style: const TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              flutterSwitch,
              Container(
                alignment: Alignment.centerRight,
                child: Text("Value: $value"),
              ),
            ],
          )
        ]
    );
  }
}