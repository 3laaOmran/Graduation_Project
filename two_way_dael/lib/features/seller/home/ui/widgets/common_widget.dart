
import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';

Widget commonContainer({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [ColorManager.mainOrange, Colors.yellow],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp)),
    child: child,
  );
}