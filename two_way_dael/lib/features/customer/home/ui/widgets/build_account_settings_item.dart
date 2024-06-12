import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';

Widget buildAccountSettingsItem(
    {double? width, required String image, required String text}) {
  return Row(
    children: [
      Image(
        image: AssetImage(image),
        width: width ?? 20,
      ),
      horizontalSpace(10),
      Text(
        text,
        style: TextStyles.font15BlackRegular,
      ),
    ],
  );
}
