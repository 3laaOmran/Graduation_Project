import 'package:flutter/material.dart';

Widget customIconButton({
  required Function() onPressed,
  required IconData? icon,
  Color? color,
  double? size,
  EdgeInsetsGeometry? padding,
  required String toolTip,
}) =>
    IconButton(
      padding: padding,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
      tooltip: toolTip,
    );
