import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/colors.dart';
import '../../config/theme/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.image,
    required this.onPressed,
    this.isClicked = true,
  });

  final String text;
  final String image;
  final VoidCallback? onPressed;
  final bool? isClicked;
  //final Color primaryColor = AppColor.primaryLight;
  //final Color onPrimaryColor= AppColor.onPrimaryLight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: isClicked! ? ElevatedButton.styleFrom(
          backgroundColor: image == ''
              ? theme.primary
              : theme.background,
          surfaceTintColor: theme.secondary,
          foregroundColor: theme.secondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ) : ElevatedButton.styleFrom(
          backgroundColor: image == ''
              ? AppColor.gray300
              : AppColor.gray300,
          surfaceTintColor: theme.secondary,
          foregroundColor: theme.secondary,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        child: image == ''
            ? Center(
                child: Text(
                  text,
                  style: Styles.textStyle16.copyWith(color: Colors.white,fontWeight: FontWeight.w500),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    text,
                    style: Styles.textStyle16.copyWith(color: theme.onSecondary,),
                  ),
                ],
              ),
      ),
    );
  }
}
