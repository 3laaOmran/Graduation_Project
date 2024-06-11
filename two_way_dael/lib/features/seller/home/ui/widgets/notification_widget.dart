import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget notificationButton(int index) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: index == 2 ? Colors.white : Colors.black54,
            )),
      ),
      index == 2
          ? const Positioned(
              top: 11,
              right: 12,
              child: Icon(
                Icons.brightness_1,
                size: 12,
                color: Colors.white,
              ),
            )
          : Container(),
      const Positioned(
        top: 12,
        right: 13,
        child: Icon(
          Icons.brightness_1,
          size: 10,
          color: Colors.red,
        ),
      ),
    ],
  );
}
