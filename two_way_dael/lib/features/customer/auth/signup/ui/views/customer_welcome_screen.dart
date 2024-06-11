import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';

class CustomerWelcomeScreen extends StatelessWidget {
  const CustomerWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Account Created Successfully',
                  style: TextStyles.font25blackbold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(50),
                Text(
                  'Go Ahead Now And Enjoy Hot Offers',
                  style: TextStyles.font18Grey800bold,
                ),
                verticalSpace(10),
                AppTextButton(
                    textStyle: TextStyles.font17WhiteBold,
                    buttonText: 'Start your journey',
                    onPressed: () {
                      context.pushNamedAndRemoveUntil(
                        Routes.homeScreen,
                        predicate: (route) => false,
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
