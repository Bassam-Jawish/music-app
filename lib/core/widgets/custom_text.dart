import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/colors.dart';
import '../../config/theme/styles.dart';

class TextSeeAll extends StatelessWidget {
  TextSeeAll(
      {required this.text, this.widget, Key? key})
      : super(key: key);

  final String text;
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColorDark,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(right: 20.w,left: 20.w ,top: 20.h,bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            widget == null ? Container() : widget!,
          ],
        ),
      ),
    );
  }
}

Widget seeAll(GestureTapCallback? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      'See all',
      style: Styles.textStyle14.copyWith(color: AppColor.primaryDark,fontWeight: FontWeight.w500),
    ),
  );
}

Widget clearAll() {
  return GestureDetector(
    onTap: () {},
    child: Row(
      children: [
        Text(
          'Clear All',
          style: Styles.textStyle12,
        ),
        const Icon(Icons.clear_all_outlined)
      ],
    ),
  );
}


Widget addNewAddress() {
  return GestureDetector(
    onTap: () {},
    child: Row(
      children: [
        const Icon(Icons.add,color: Colors.blue,),
        Text(
          'ADD NEW ADDRESS',
          style: Styles.textStyle12.copyWith(color: Colors.blue),
        ),
      ],
    ),
  );
}