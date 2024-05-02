import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/widgets/account_settings.dart';
import 'package:two_way_dael/features/home/ui/widgets/change_profile_photo.dart';
import 'package:two_way_dael/features/home/ui/widgets/edit_info.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  Widget currentWidget = accountSettings();
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/profile_bg.png',
                    ),
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Column(
                      children: [
                        verticalSpace(38),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentWidget = const ChangeProfilePhoto();
                              icon = Icons.arrow_back;
                            });
                          },
                          child: Stack(
                            children: [
                              const CircleAvatar(
                                radius: 80.0,
                                backgroundImage: AssetImage(
                                    'assets/images/default_profile.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 13,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.edit_square,
                                    color: Colors.grey[300],
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
                              currentWidget = editInfo();
                              icon = Icons.arrow_back;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hello, Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                  ),
                                  horizontalSpace(8),
                                  Icon(
                                    Icons.edit_square,
                                    size: 12,
                                    color: Colors.grey[300],
                                  )
                                ],
                              ),
                              Text(
                                'Egypt',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 35,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        customIconButton(
                          onPressed: () {
                            context.pushNamed(Routes.notificationsScreen);
                          },
                          icon: Icons.notifications,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            top: 11.0,
                            end: 12.0,
                          ),
                          child: const CircleAvatar(
                            radius: 4.5,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 3.5,
                              backgroundColor: ColorManager.mainOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: customIconButton(
                      onPressed: () {
                        setState(() {
                          currentWidget = accountSettings();
                          icon = null;
                        });
                      },
                      icon: icon,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              currentWidget,
            ],
          ),
        );
      },
    );
  }
}
