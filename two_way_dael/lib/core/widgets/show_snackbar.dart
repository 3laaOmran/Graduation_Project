import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';

void showSnackBar(context, {required String message}) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: message,
      style: TextStyles.font17WhiteBold.copyWith(fontSize: 15),
    ),
    maxLines: 5,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  final textHeight = textPainter.size.height;

  final snackBarHeight =
      textHeight + 2 * 30 + 30.h; 
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      clipBehavior: Clip.hardEdge,
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - snackBarHeight,
      ),
      duration: const Duration(seconds: 5),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      content: Center(
        child: Text(
          message,
          style: TextStyles.font17WhiteBold.copyWith(fontSize: 15),
        ),
      ),
      backgroundColor: ColorManager.mainOrange,
    ),
  );
}
