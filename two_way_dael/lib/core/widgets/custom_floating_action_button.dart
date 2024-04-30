import 'package:flutter/material.dart';

import '../../../core/theming/colors.dart';

Widget floatingactionButton(
  double width,
  double height,
  String name,
  String herotext,
) {
  return FloatingActionButton(
    heroTag: herotext,
    backgroundColor: Colors.white,
    onPressed: () {},
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: const BorderSide(color: ColorManager.mainOrange),
    ),
    child: CircleAvatar(
      radius: 250,
      backgroundColor: ColorManager.mainOrange,
      backgroundImage: AssetImage('assets/images/Google.png'),
    ),
  );
}
