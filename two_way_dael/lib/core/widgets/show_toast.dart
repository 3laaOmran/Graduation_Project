import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:two_way_dael/core/theming/colors.dart';

void showToast({
  required String message,
  required TostStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum TostStates { SUCCESS, ERROR, WARNING, others }

Color chooseToastColor(TostStates state) {
  Color color;
  switch (state) {
    case TostStates.SUCCESS:
      color = Colors.green;
      break;
    case TostStates.ERROR:
      color = Colors.red;
      break;
    case TostStates.WARNING:
      color = Colors.amber;
      break;
    case TostStates.others:
      color = ColorManager.mainOrange;
      break;
  }
  return color;
}
