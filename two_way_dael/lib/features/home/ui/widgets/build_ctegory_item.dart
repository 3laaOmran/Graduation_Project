import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';

Widget buildCategoryItem(context, {required String text}) => Container(
        width: 53.0,
        height: 23.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: ColorManager.mainOrange,
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 9.0,
                  color: ColorManager.mainOrange,
                ),
          ),
        ),
      );
