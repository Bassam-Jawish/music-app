import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/colors.dart';

PreferredSizeWidget CustomAppBar() {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.sort_rounded, size: 30, color: Colors.white.withOpacity(0.5),),
    ),
    centerTitle: true,
    backgroundColor: AppColor.transparent,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    elevation: 1,
    titleTextStyle: TextStyle(
        fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, size: 30, color: Colors.white.withOpacity(0.5),)),
    ],
  );
}
