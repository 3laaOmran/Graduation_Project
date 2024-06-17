import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';

class BuildCategoryItem extends StatefulWidget {
  const BuildCategoryItem({super.key, required this.text});
  final String text;

  @override
  State<BuildCategoryItem> createState() => _BuildCategoryItemState();
}


class _BuildCategoryItemState extends State<BuildCategoryItem> {
bool istapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          istapped = !istapped;
        });
      },
      child: Container(
        width: 60.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: istapped ? ColorManager.mainOrange : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: ColorManager.mainOrange,
            width: 1.3,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: istapped ? Colors.white : ColorManager.mainOrange,
                ),
          ),
        ),
      ),
    );
  }
}
