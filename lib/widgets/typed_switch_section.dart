import 'package:flutter/material.dart';
import 'package:rs_flutter_test/models/enums/section_switch_type.dart';
import 'package:rs_flutter_test/widgets/typed_switch.dart';

class TypedSwitchSection extends StatelessWidget {
  const TypedSwitchSection({
    super.key,
    required this.type,
    required this.value,
    required this.onToggle,
  });

  final SectionSwitchType type;
  final bool value;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type.title),
        if (type.subtitle != null)
          Text(
            type.subtitle!,
            style: const TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TypedSwitch(
              type: type,
              value: value,
              onToggle: onToggle,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text('Value: $value'),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
