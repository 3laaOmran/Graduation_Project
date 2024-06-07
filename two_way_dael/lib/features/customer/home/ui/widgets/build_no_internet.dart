import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/styles.dart';

Widget buildNoInternetWidget() {
  return Center(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_internet.png'),
          Text(
            'Ooops!',
            style: TextStyles.font50black54bold,
          ),
          Text(
            'No internet connection found \n \t\t\t\t Check your connection',
            style: TextStyles.font15GrayRegular,
          ),
        ],
      ),
    ),
  );
}
