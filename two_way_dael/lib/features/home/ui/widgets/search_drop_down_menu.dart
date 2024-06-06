import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';

Widget searchDropDownMenue({
  required String title,
  required String value,
  required List<DropdownMenuItem<String>>? items,
  required Function(String?)? onChange,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyles.font14BlackBold,
      ),
      verticalSpace(5),
      DropdownButton<String>(
        menuMaxHeight: 500.h,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: Colors.white,
        // alignment: Alignment.center,
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        underline: Container(
          height: 2.h,
          color: ColorManager.gray,
        ),
        isDense: true,
        isExpanded: true,
        items: items,
        onChanged: onChange,
      ),
    ],
  );
}
