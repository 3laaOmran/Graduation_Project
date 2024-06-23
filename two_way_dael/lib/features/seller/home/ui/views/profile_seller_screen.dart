import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/seller_account_settings.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/seller_change_logo.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/seller_info.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

class ProfileSellerScreen extends StatefulWidget {
  const ProfileSellerScreen({super.key});

  @override
  State<ProfileSellerScreen> createState() => _ProfileSellerScreenState();
}

class _ProfileSellerScreenState extends State<ProfileSellerScreen> {
  Widget currentWidget = const SellerAccountSettings();
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        // if (state is GetUserDataLoadingState) {}
      },
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        var model = cubit.sellerDataModel;
        cubit.nameController.text = model!.data!.name!;
        var image = model.data!.image;
        var rate = double.tryParse('${model.data!.rate}') ?? 0.0;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  // const Image(
                  //   image: AssetImage(
                  //     'assets/images/profile_bg.png',
                  //   ),
                  //   width: double.infinity,
                  //   height: 320,
                  //   fit: BoxFit.cover,
                  // ),
                  Center(
                    child: Column(
                      children: [
                        verticalSpace(50),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentWidget = const SellerChangeLogo();
                              icon = Icons.arrow_back;
                            });
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 100.0,
                                backgroundImage: image ==
                                        'http://2waydeal.online/uploads/default.png'
                                    ? const AssetImage(
                                            'assets/images/default_profile.png')
                                        as ImageProvider
                                    : NetworkImage(image!),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 13,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        verticalSpace(20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentWidget = const SellerEditInfo();
                              icon = Icons.arrow_back;
                            });
                            // cubit.getGovernorates();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.nameController.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                  ),
                                  horizontalSpace(8),
                                  const Icon(
                                    Icons.visibility,
                                    size: 12,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                              verticalSpace(5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: rate,
                                    itemCount: 5,
                                    itemSize: 30.0,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: ColorManager.mainOrange,
                                    ),
                                  ),
                                  verticalSpace(20),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 10.w,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        customIconButton(
                          toolTip: 'Notifications',
                          onPressed: () {
                            context.pushNamed(Routes.sellerNotificationsScreen);
                          },
                          icon: Icons.notifications,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        if (cubit.sellerNotificationsModel?.data?.isNotEmpty ==
                                true &&
                            cubit.sellerNotificationsModel!.data!.first
                                    .isRead ==
                                false)
                          Container(
                            padding: const EdgeInsetsDirectional.only(
                              top: 11.0,
                              end: 14.0,
                            ),
                            child: const CircleAvatar(
                              radius: 3.5,
                              backgroundColor: ColorManager.mainOrange,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: customIconButton(
                      toolTip: 'back',
                      onPressed: () {
                        setState(() {
                          currentWidget = const SellerAccountSettings();
                          icon = null;
                        });
                      },
                      icon: icon,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              PageTransitionSwitcher(
                duration: const Duration(milliseconds: 900),
                transitionBuilder: (Widget child,
                    Animation<double> primaryAnimation,
                    Animation<double> secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.vertical,
                    child: child,
                  );
                },
                child: currentWidget,
              ),
            ],
          ),
        );
        // : ProfileSkeltonLoading();
      },
    );
  }
}
