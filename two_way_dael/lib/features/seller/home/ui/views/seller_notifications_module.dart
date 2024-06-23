import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class SellerNotificationsModule extends StatefulWidget {
  const SellerNotificationsModule({super.key});

  @override
  State<SellerNotificationsModule> createState() =>
      _SellerNotificationsModuleState();
}

class _SellerNotificationsModuleState extends State<SellerNotificationsModule> {
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
                state.notificationDetails.data!.title!,
                style: TextStyles.font28MainOrangeBold.copyWith(
                  fontSize: 20,
                ),
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.notificationDetails.data!.content!,
                    style: TextStyles.font15BlackBold,
                  ),
                  verticalSpace(15),
                  Text('Craeted At: ', style: TextStyles.font15BlackBold),
                  Text(
                    state.notificationDetails.data!.createdAt!,
                    style: TextStyles.font15GrayRegular,
                  ),
                  verticalSpace(5),
                  Text('Available For: ', style: TextStyles.font15BlackBold),
                  Text(
                    state.notificationDetails.data!.lastUpdated!,
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
          body: cubit.sellerNotificationsModel?.data?.isEmpty == true
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
                    return InkWell(
                      onTap: () {
                        setState(() {
                          cubit.sellerNotificationsModel!.data![index].isRead =
                              true;
                          cubit.getNotificationDetails(
                              id: cubit
                                  .sellerNotificationsModel!.data![index].id!);
                        });
                      },
                      child: Container(
                        height: 100,
                        color: !cubit
                                .sellerNotificationsModel!.data![index].isRead!
                            ? ColorManager.notificationColor
                            : Colors.white,
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundColor: !cubit.sellerNotificationsModel!
                                      .data![index].isRead!
                                  ? ColorManager.notificationColor
                                  : Colors.white,
                              child: Image.asset(
                                cubit.sellerNotifications[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(
                              cubit.sellerNotifications[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.font17BlackBold,
                            ),
                            subtitle: Text(
                              cubit.sellerNotifications[index].message,
                              maxLines: 1,
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
                    return Container(
                      color:
                          cubit.sellerNotificationsModel!.data![index].isRead!
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
  NotificationItem({
    required this.title,
    required this.message,
    required this.image,
  });
}
