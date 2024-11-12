
import 'package:flutter/material.dart';

class UIConstants {
  static double elevation = 2.0;

  static double boxItemHeight50 = 50;
  static double boxItemHeight60 = 60;

  static double textFieldHeight50 = 50;
  static double textFieldHeight55 = 55;

  static double buttonHeight50 = 55;
  static double buttonHeight55 = 55;
  static double buttonHeight60 = 60;

  static double borderLightWidth = 1.5;
  static double borderMediumWidth = 2;
  static double borderBordWidth = 3;

  static BorderRadiusGeometry borderRadius = BorderRadius.circular(30);
  static BorderRadiusGeometry borderMediumRadius = BorderRadius.circular(20);
  static BorderRadiusGeometry borderLightRadius = BorderRadius.circular(6);

  static Radius radius = const Radius.circular(30);
  static Radius mediumRadius = const Radius.circular(20);
  static Radius lightRadius = const Radius.circular(12);

  static const double radiusValue30 = 30;
  static const double radiusValue20 = 20;
  static const double radiusValue10 = 10;

  static EdgeInsets viewPadding = const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0);

  static double progressIndicatorSize = 35.0;


  /// font size fixation
  static MediaQueryData getScaleFontSize(BuildContext context,
      {double fontSize = 1.0}) =>
      MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(fontSize));

}