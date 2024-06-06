import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';

Widget buildSearchFilterItem({
  required String text,
  required Function()? ontap,
  Color? bgColor,
  Color? borderColor,
  Color? textColor,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          border: Border.all(
            width: 1.5.w,
            color: borderColor ?? ColorManager.gray,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: TextStyles.font14BlackBold
              .copyWith(color: textColor ?? Colors.black),
        ),
      ),
    ),
  );
}
