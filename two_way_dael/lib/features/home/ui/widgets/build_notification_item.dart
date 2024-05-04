import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
Widget buildNotificationItem() {
  return Container(
    color: ColorManager.notificationColor,
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/default_profile.png'),
          ),
        ),
        
        Expanded(
          child: SizedBox(
            height: 110,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Message Title',
                    style: TextStyles.font17BlackBold,
                  ),
                  Expanded(
                    child: Text(
                      'Content Content Content Content Content Content ',
                      style: TextStyles.font13GreyBold,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}