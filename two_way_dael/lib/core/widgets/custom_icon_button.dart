import 'package:flutter/material.dart';

Widget customIconButton({
  required Function() onPressed,
  required IconData? icon,
  Color? color,
  double? size,
  required String toolTip,
}) =>
    IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
      tooltip: toolTip,
    );
