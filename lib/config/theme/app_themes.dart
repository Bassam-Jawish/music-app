import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/gen/fonts.gen.dart';
import 'colors.dart';

ThemeData theme() {
  return ThemeData(
      useMaterial3: true,
      fontFamily: FontFamily.publicSans,
      appBarTheme: appBarTheme(),
      colorScheme: const ColorScheme(
        surfaceContainerHighest: AppColor.onBackgroundColorDark,
        brightness: Brightness.dark,
        primary: AppColor.primaryDark,
        onPrimary: AppColor.onPrimaryDark,
        secondary: AppColor.secondaryDark,
        onSecondary: AppColor.onSecondaryDark,
        error: AppColor.errorDark,
        onError: AppColor.onErrorDark,
        surface: AppColor.surfaceDark,
        onSurface: AppColor.onSurfaceDark,
      ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: AppColor.backgroundColorDark,
    foregroundColor: Colors.black,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.sp,fontFamily: 'PublicSans',fontWeight: FontWeight.bold),
  );
}

