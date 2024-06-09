import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

class ChooseAccountTypeScreen extends StatelessWidget {
  const ChooseAccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/main_background.png'),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Your Account Type',
                  style: TextStyles.font20blackbold,
                ),
                verticalSpace(50),
                Row(
                  children: [
                    Expanded(
                      child: AppTextButton(
                        buttonText: 'Customer',
                        textStyle: TextStyles.font17WhiteBold,
                        onPressed: () {
                          context.pushNamedAndRemoveUntil(Routes.loginScreen,
                              predicate: (route) => false);
                        },
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: AppTextButton(
                        buttonText: 'Seller',
                        textStyle: TextStyles.font17WhiteBold,
                        onPressed: () {
                          context.pushNamedAndRemoveUntil(
                              Routes.sellerLoginScreen,
                              predicate: (route) => false);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
