import 'package:flutter/material.dart';

abstract class AppColor {
  const AppColor();

  static const Color dialogSuccess = Color(0xff01E47A);
  static const Color dialogFailed = Color(0xffFE5151);
  static const Color transparent = Colors.transparent;

  /// Dark
  static const Color backgroundColorDark = Color(0xFF403151);
  static const Color onBackgroundColorDark= Color(0xFF899CCF);
  static const Color primaryDark = Color(0xFF403151);
  static const Color onPrimaryDark = Color(0xFF899CCF);
  static const Color secondaryDark = Color(0xFF899CCF);
  static const Color shadeColor = Color(0xFFBCBCBC);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color borderDarkOnFocus = Color(0xFFFFFFFF);
  static const Color errorDark = Colors.redAccent;
  static const Color onErrorDark = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFFFEEE6);
  static const Color onSurfaceDark = Color(0xFF121212);
  static const Color successColor = Color(0xFF24B364);

  // Gray
  static const Color gray100 = Color(0XFFF2F4F6);
  static const Color gray300 = Color(0XFFE0E2E4);
  static const Color gray500 = Color(0XFF90979E);
  static const Color gray600 = Color(0XFF6D747C);
  static const Color gray700 = Color(0X147C7C7C);

  // Shimmer Color

  static const Color shimmerBaseColor = Color(0xFF30314D);
  static const Color shimmerHighlightColor = Color(0xFF60618A);

}