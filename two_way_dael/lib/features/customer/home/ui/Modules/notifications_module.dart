import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerStates>(
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: customIconButton(
              toolTip: 'back',
              onPressed: () {
                context.pop();
              },
              icon: Icons.arrow_back,
              color: Colors.white,
            ),
            backgroundColor: ColorManager.mainOrange,
            title: Text(
              'Notifications',
              style: TextStyles.font20Whitebold,
            ),
          ),
          body: ListView.separated(
              itemCount: cubit.notifications.length,
              itemBuilder: (context, index) {
                final notification = cubit.notifications[index];
                return Dismissible(
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
                  key: Key(cubit.notifications[index].title),
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Center(child: Text('Are you sure ?!')),
                        content:
                            const Text('You want to delete this notification'),
                        actions: [
                          AppTextButton(
                            buttonText: 'Yes',
                            textStyle: TextStyles.font12White,
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            buttonWidth: 30,
                            buttonHeight: 15,
                          ),
                          AppTextButton(
                            buttonText: 'No',
                            textStyle: TextStyles.font12White,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            buttonWidth: 30,
                            buttonHeight: 15,
                          ),
                        ],
                      ),
                    );
                    return result;
                  },
                  onDismissed: (direction) {
                    cubit.deleteNotificatins(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        duration: const Duration(milliseconds: 900),
                        content: Center(
                          child: Text(
                            'Notification deleted',
                            style: TextStyles.font18White,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    color: notification.isNew
                        ? ColorManager.notificationColor
                        : Colors.white,
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage(cubit.notifications[index].image),
                        ),
                        title: Text(
                          cubit.notifications[index].title,
                        ),
                        subtitle: Text(
                          cubit.notifications[index].message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: customIconButton(
                            onPressed: () {
                              cubit.showNotificationDetails(
                                  cubit.notifications[index], context);
                            },
                            icon: Icons.info,
                            toolTip: 'View',
                            color: notification.isNew
                                ? ColorManager.mainOrange
                                : ColorManager.gray),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                final notification = cubit.notifications[index];
                return Container(
                  color: !notification.isNew
                      ? Colors.white
                      : ColorManager.notificationColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String image;
  bool isNew;
  NotificationItem({
    this.isNew = true,
    required this.title,
    required this.message,
    required this.image,
  });
}
