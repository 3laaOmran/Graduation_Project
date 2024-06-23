import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class SellerNotificationsModule extends StatelessWidget {
  const SellerNotificationsModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        if (state is GetNotificationDetailsSuccessState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Center(
                  child: Text(
                state.notificationDetails.notificationData!.title!,
                style: TextStyles.font28MainOrangeBold.copyWith(
                  fontSize: 20,
                ),
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.notificationDetails.notificationData!.body!,
                    style: TextStyles.font15BlackBold,
                  ),
                  verticalSpace(15),
                  Text('Craeted At: ', style: TextStyles.font15BlackBold),
                  Text(
                    state.notificationDetails.notificationData!.createdAt!,
                    style: TextStyles.font15GrayRegular,
                  ),
                  verticalSpace(5),
                  Text('Available For: ', style: TextStyles.font15BlackBold),
                  Text(
                    state.notificationDetails.notificationData!.lastUpdated!,
                    style: TextStyles.font15GrayRegular,
                  ),
                ],
              ),
              actions: [
                AppTextButton(
                  buttonText: 'Close',
                  textStyle: TextStyles.font12White,
                  onPressed: () {
                    context.pop();
                  },
                  buttonWidth: 80,
                  buttonHeight: 15,
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.notificationColor,
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
          body: cubit.sellerNotificationsModel?.data?.notifications?.isEmpty ==
                  true
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    'No Notifications For You Yet',
                    textAlign: TextAlign.center,
                    style:
                        TextStyles.font17MainOrangeBold.copyWith(fontSize: 25),
                  )),
                )
              : ListView.separated(
                  itemCount: cubit.sellerNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = cubit.sellerNotifications[index];
                    return InkWell(
                      onTap: () {
                        cubit.getNotificationDetails(
                            id: cubit.sellerNotificationsModel!.data!
                                .notifications![index].id!);
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
                              backgroundColor: notification.isNew
                                  ? ColorManager.notificationColor
                                  : Colors.white,
                              child: Image.asset(
                                cubit.sellerNotifications[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(
                              cubit.sellerNotifications[index].title,
                              style: TextStyles.font20blackbold,
                            ),
                            subtitle: Text(
                              cubit.sellerNotifications[index].message,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: customIconButton(
                              onPressed: () {},
                              icon: Icons.info,
                              color: ColorManager.mainOrange,
                              toolTip: '',
                            ),
                          ),
                        ),
                      ),
                      // ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    final notification = cubit.sellerNotifications[index];
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
