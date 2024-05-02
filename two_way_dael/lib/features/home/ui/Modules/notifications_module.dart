import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: ColorManager.mainOrange,
          title: Text(
            'Notifications',
            style: TextStyles.font20Whitebold,
          ),
        ),
        body: ListView.separated(
          itemCount: 15,
          itemBuilder: (context, index) => buildNotificationItem(),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.5,
            color: Colors.black,
          ),
        ));
  }
}

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
        // Image(
        //   image: AssetImage('assets/images/default_profile.png'),
        //   width: 110,
        // ),
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
