import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
        itemCount: notifications.length,
        itemBuilder: (context, index) => Dismissible(
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 50,
            ),
          ),
          secondaryBackground: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 50,
            ),
          ),
          key: ValueKey<Widget>(notifications[index]),
          onDismissed: (DismissDirection direction) {
            setState(() {
              notifications.removeAt(index);
            });
          },
          child: notifications[index],
        ),
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
      ),
    );
  }
}

List<Widget> notifications = [
  buildNotificationItem(),
  buildNotificationItem(),
  buildNotificationItem(),
  buildNotificationItem(),
  buildNotificationItem(),
  buildNotificationItem(),
  buildNotificationItem(),
];
