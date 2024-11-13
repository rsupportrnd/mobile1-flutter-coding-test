
import 'package:flutter/material.dart';

class UIConstants {
  static double elevation = 2.0;

  static double tileHeight50 = 50;
  static double tileHeight90 = 90;

  static double textFieldHeight50 = 50;
  static double textFieldHeight55 = 55;

  static double buttonHeight50 = 55;
  static double buttonHeight55 = 55;
  static double buttonHeight60 = 60;

  static double borderLightWidth = 1.5;
  static double borderMediumWidth = 2;
  static double borderBordWidth = 3;

  // elevation
  static double elevation1 = 1;
  static double elevation2 = 2;
  static double elevation3 = 3;
  static double elevation4 = 4;

  // border radius
  static BorderRadiusGeometry borderLightRadius = BorderRadius.circular(6);
  static BorderRadiusGeometry borderMediumRadius = BorderRadius.circular(20);
  static BorderRadiusGeometry borderRadius = BorderRadius.circular(30);
  static BorderRadiusGeometry borderCircle = BorderRadius.circular(50);

  // radius
  static Radius lightRadius = const Radius.circular(12);
  static Radius mediumRadius = const Radius.circular(20);
  static Radius radius = const Radius.circular(30);

  /// font size fixation
  static MediaQueryData getScaleFontSize(BuildContext context,
      {double fontSize = 1.0}) =>
      MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(fontSize));

}