import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';

void showSnackBar(context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      padding: const EdgeInsets.symmetric(vertical: 30),
      content: Center(
          child: Text(
        message,
        style: TextStyles.font17WhiteBold.copyWith(fontSize: 15),
      )),
      backgroundColor: ColorManager.mainOrange,
    ),
  );
}
