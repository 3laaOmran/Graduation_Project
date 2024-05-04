import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
Widget buildDropDownList({
  required List<String> list,
  required String selectedItem,
}) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 2,
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
