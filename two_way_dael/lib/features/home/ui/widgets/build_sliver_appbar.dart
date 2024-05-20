import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';

Widget buildSliverAppBar(context) {
  return SliverAppBar(
    leading: customIconButton(
      toolTip: 'back',
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icons.arrow_back,
      color: ColorManager.mainOrange,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: ColorManager.mainOrange,
          child: Center(
            child: customIconButton(
              padding: const EdgeInsets.only(
                left: 2.0,
                right: 2.0,
                top: 3.0,
                bottom: 2.0,
              ),
              onPressed: () {},
              icon: Icons.favorite,
              color: Colors.white,
              size: 25.0,
              toolTip: 'Favorite',
            ),
          ),
        ),
      ),
    ],
    centerTitle: true,
    expandedHeight: 450,
    toolbarHeight: 60,
    pinned: true,
    stretch: true,
    backgroundColor: Colors.white,
    flexibleSpace: FlexibleSpaceBar(
      // centerTitle: true,
      title: const Text(
        '\t Seller Name',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: ColorManager.mainOrange,
        ),
      ),
      background: Hero(
        tag: 1,
        child: Image.asset(
          'assets/images/default_profile.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
