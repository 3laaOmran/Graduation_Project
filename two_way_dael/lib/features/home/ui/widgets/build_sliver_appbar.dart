 import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';

Widget buildSliverAppBar(context) {
    return SliverAppBar(
      leading: customIconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icons.arrow_back,
        color: ColorManager.mainOrange,
      ),
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
          ),
        ),
      ),
    );
  }