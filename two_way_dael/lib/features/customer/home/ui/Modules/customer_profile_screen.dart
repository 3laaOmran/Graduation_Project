import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/account_settings.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/change_profile_photo.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/edit_info.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  Widget currentWidget = const AccountSettings();
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetUserDataLoadingState) {}
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var model = cubit.userDataModel;
        cubit.nameController.text = model!.data!.name!;
        var image = model.data!.profilePicture;
        return state is! GetUserDataLoadingState
            ? SingleChildScrollView(
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
                        //   height: 280,
                        //   fit: BoxFit.cover,
                        // ),
                        Center(
                          child: Column(
                            children: [
                              verticalSpace(50),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentWidget = const ChangeProfilePhoto();
                                    icon = Icons.arrow_back;
                                  });
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
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
                                      right: 15,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(
                                          Icons.edit_square,
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
                                    currentWidget = const EditInfo();
                                    icon = Icons.arrow_back;
                                  });
                                  // cubit.getGovernorates();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          Icons.edit_square,
                                          size: 12,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    Text(
                                      'Egypt',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11.0),
                                    ),
                                    verticalSpace(30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          child: Stack(
                            alignment:
                                cubit.notificationsModel?.data?.first.isRead ==
                                        false
                                    ? AlignmentDirectional.topEnd
                                    : AlignmentDirectional.center,
                            children: [
                              customIconButton(
                                onPressed: () {
                                  context.pushNamed(Routes.notificationsScreen);
                                },
                                icon: Icons.notifications,
                                toolTip: 'Notifications',
                                size: 30.0,
                              ),
                              cubit.notificationsModel!.data!.first.isRead ==
                                      false
                                  ? Container(
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 11.0,
                                        end: 14.0,
                                      ),
                                      child: const CircleAvatar(
                                        radius: 3.5,
                                        backgroundColor:
                                            ColorManager.mainOrange,
                                      ),
                                    )
                                  : Container(),
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
                                currentWidget = const AccountSettings();
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
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.mainOrange,
                ),
              );
      },
    );
  }
}
