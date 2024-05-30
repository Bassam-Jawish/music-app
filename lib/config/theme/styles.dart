import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static TextStyle textStyle12 = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis);
  static TextStyle textStyle14 = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis);

  static TextStyle textStyle16 = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
      overflow: TextOverflow.ellipsis);
  static TextStyle textStyle18 = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis);
  static TextStyle textStyle20 = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      overflow: TextOverflow.ellipsis,
  );
  static TextStyle textStyle24 = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis);
  static TextStyle textStyle30 = TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w900,
      overflow: TextOverflow.ellipsis);
}

const TextStyle textStyle = TextStyle();
