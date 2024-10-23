import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ColumnWithSpace extends StatelessWidget {
  final List<Widget> children;
  final double space;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  const ColumnWithSpace(
      {super.key,
      this.direction = Axis.vertical,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection = VerticalDirection.down,
      this.textBaseline,
      required this.children,
      required this.space});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children.mapIndexed((index, child) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: index == children.length - 1 ? 0 : space),
          child: child,
        );
      }).toList(),
    );
  }
}
