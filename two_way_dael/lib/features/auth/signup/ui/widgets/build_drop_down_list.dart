import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/theming/colors.dart';

Widget buildDropDownList({
  required List<String> list,
  required String selectedItem,
}) {
  return SizedBox(
    width: double.infinity,
    height: 55.h,
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorManager.gray,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 1.3,
            color: ColorManager.mainOrange,
          ),
        ),
      ),
      value: selectedItem,
      items: list
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (item) => selectedItem = item!,
    ),
  );
}
