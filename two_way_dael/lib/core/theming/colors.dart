import 'package:flutter/material.dart';

class ColorManager {
  static const Color mainOrange = Color(0xffFD4B03);
  static const Color gray = Color(0xffafafaf);
  static const Color notificationColor = Color(0xffFFE9E0);
  static Color mixedColor =
      Color.alphaBlend(ColorManager.mainOrange, Colors.orangeAccent);
}
