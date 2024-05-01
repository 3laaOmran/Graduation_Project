import 'package:flutter/material.dart';

Widget customIconButton({
  required Function() onPressed,
  required IconData icon,
   Color? color,
  double? size,
}) =>
    IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
