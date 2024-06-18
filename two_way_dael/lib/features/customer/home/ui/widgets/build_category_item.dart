import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/customer/home/data/models/categoties_model.dart';

Widget buildCatItem(BuildContext context, CategoryData data, {bool isSelected = false}) {
  return Container(
    width: 53.0,
    height: 23.0,
    decoration: BoxDecoration(
      color: isSelected ? ColorManager.mainOrange : Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(
        color: ColorManager.mainOrange,
        width: 1.3,
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Center(
      child: Text(
        '${data.name}',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
              color: isSelected ? Colors.white : ColorManager.mainOrange,
            ),
      ),
    ),
  );
}