import 'package:flutter/material.dart';

class SwitchSection extends StatelessWidget {
  const SwitchSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.tail,
    required this.switchBuilder,
  });

  final String title;
  final String? subtitle;
  final String tail;
  final Widget Function(BuildContext) switchBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        if (subtitle != null)
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            switchBuilder.call(context),
            Container(
              alignment: Alignment.centerRight,
              child: Text(tail),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
