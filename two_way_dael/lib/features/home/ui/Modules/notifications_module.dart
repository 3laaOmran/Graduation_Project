import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_notification_item.dart';

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
            color: ColorManager.notificationColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
          ),
        ));
  }
}
