import 'package:flutter/material.dart';

class SwitchRow extends StatefulWidget {
  final String title;
  final String? subTitle;
  final bool status;
  final Widget flutterSwitch;

  const SwitchRow({
      required this.title,
      this.subTitle,
      required this.status,
      required this.flutterSwitch,
      Key? key})
      : super(key: key);

  @override
  State<SwitchRow> createState() => _SwitchRowState();
}

class _SwitchRowState extends State<SwitchRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        if (widget.subTitle != null)
          Text(
            widget.subTitle!,
            style: const TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.flutterSwitch,
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Value: ${widget.status}",
              ),
            )
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
