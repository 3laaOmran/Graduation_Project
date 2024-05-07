import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/theming/styles.dart';

import '../../../core/theming/colors.dart';

Widget floatingactionButton({
  required Function()? onPressed,
  required String text,
}) {
  return SizedBox(
    width: 150.w,
    child: FloatingActionButton(
      backgroundColor: ColorManager.mainOrange,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyles.font18White,
      ),
    ),
  );
}
