import 'package:flutter/material.dart';

import '../../../common/common.dart';

class StyleText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign align;
  final TextOverflow overflow;
  final int maxLinesCount;
  final bool softWrap;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const StyleText({
    super.key,
    required this.text,
    this.color,
    this.size = AppDim.fontSizeMedium,
    this.fontWeight = FontWeight.normal,
    this.align = TextAlign.start,
    this.overflow = TextOverflow.visible,
    this.maxLinesCount = 1,
    this.softWrap = false,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: const TextScaler.linear(AppDim.scaleFontSize),
      overflow: overflow,
      maxLines: maxLinesCount,
      softWrap: softWrap,
      style: TextStyle(
          color: color ?? AppColors.textBlack,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
      ),
      textAlign: align,
    );
  }
}
