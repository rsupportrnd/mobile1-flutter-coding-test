import 'package:flutter/material.dart';

class AppDim {

  // 일반 사이즈
  static const  double xSmall = 5;
  static const  double small  = 10;
  static const  double medium = 15;
  static const  double mediumLarge = 20;
  static const  double large  = 25;
  static const  double xLarge = 40;
  static const  double xXLarge = 50;

  // height
  static const  heightXSmall = SizedBox(height: xSmall);
  static const  heightSmall = SizedBox(height: small);
  static const  heightMedium = SizedBox(height: medium);
  static const  heightMediumLarge = SizedBox(height: mediumLarge);

  // width
  static const  widthXSmall = SizedBox(width: xSmall);
  static const  widthSmall = SizedBox(width: small);
  static const  widthMedium = SizedBox(width: medium);
  static const  widthMediumLarge = SizedBox(width: mediumLarge);

  // padding
  static const  paddingXxSmall = EdgeInsets.all(2);
  static const  paddingXSmall = EdgeInsets.all(5);
  static const  paddingSmall  = EdgeInsets.all(10);
  static const  paddingMedium = EdgeInsets.all(15);
  static const  paddingLarge  = EdgeInsets.all(20);
  static const  paddingXLarge = EdgeInsets.all(25);

  // margin
  static const  marginXSmall = EdgeInsets.all(5);
  static const  marginSmall  = EdgeInsets.all(10);
  static const  marginMedium = EdgeInsets.all(15);
  static const  marginLarge  = EdgeInsets.all(25);
  static const  marginXLarge = EdgeInsets.all(30);

  // 폰트 크기
  static const double scaleFontSize = 1.0;
  static const double fontSizeXxSmall = 10.0;
  static const double fontSizeXSmall = 12.0;
  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeXLarge = 20.0;
  static const double fontSizeXxLarge = 24.0;
  static const double fontSizeXxxLarge = 30.0;

  // 폰트 굵기
  static const FontWeight weightLight = FontWeight.w400;
  static const FontWeight weightNormal = FontWeight.normal;
  static const FontWeight weight500 = FontWeight.w500;
  static const FontWeight weightBold = FontWeight.bold;

  // 아이콘 크기
  static const double iconXxSmall = 12.0;
  static const double iconXSmall = 16.0;
  static const double iconSmall  = 24.0;
  static const double iconMedium = 32.0;
  static const double iconLarge  = 40.0;
  static const double iconXLarge = 48.0;

  // 이미지 크기
  static const double imageXxSmall = 30;
  static const double imageXSmall = 40;
  static const double imageSmall  = 50;
  static const double imageSmallMedium  = 60;
  static const double imageMedium = 70;
  static const double imageMediumLarge = 90;
  static const double imageLarge  = 150;
  static const double imageXlarge = 200;
}