import 'dart:io';

import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/auth/login/ui/views/forget_password_otp_screen.dart';
import 'package:two_way_dael/features/auth/login/ui/views/forget_password_view.dart';
import 'package:two_way_dael/features/auth/login/ui/views/phone_for_forget_password.dart';
import 'package:two_way_dael/features/auth/signup/ui/views/otp_screen.dart';
import 'package:two_way_dael/features/auth/signup/ui/views/photo_and_address_screen.dart';
import 'package:two_way_dael/features/home/ui/Modules/about_app.dart';
import 'package:two_way_dael/features/home/ui/Modules/contact_us_screen.dart';
import 'package:two_way_dael/features/home/ui/Modules/favorite_sellers.dart';
import 'package:two_way_dael/features/home/ui/Modules/notifications_module.dart';
import 'package:two_way_dael/features/home/ui/Modules/search_module.dart';
import 'package:two_way_dael/features/home/ui/Modules/seller_details.dart';
import 'package:two_way_dael/features/home/ui/Modules/your_orders_screen.dart';
import 'package:two_way_dael/features/home/ui/widgets/change_password_screen.dart';

import '../../features/auth/login/ui/views/login_screen.dart';
import '../../features/auth/signup/ui/views/signup_screen.dart';
import '../../features/home/ui/views/home_screen.dart';
import '../../features/onboarding/views/onboarding_screen.dart';

class AppRouter {
  Route generateRoure(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const CustomerLayoutScreen());
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (_) => const ConfirmAccount());
      case Routes.photoAddressScreen:
        return MaterialPageRoute(builder: (_) => const PhotoAndAddressScreen());
      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.phoneForForgetPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => const PhoneForForgetPasswordScreen());
      case Routes.forgetPasswordOtpScreen:
        return MaterialPageRoute(
            builder: (_) => const ForgetPasswordOtpScreen());
      case Routes.aboutAppScreen:
        return MaterialPageRoute(builder: (_) => const AboutAppScreen());
      case Routes.yourOrdersScreen:
        return MaterialPageRoute(builder: (_) => const YourOrdersScreen());
      case Routes.favoriteSellers:
        return MaterialPageRoute(builder: (_) => const FvaoriteSellers());
      case Routes.sellerDeatailsScreen:
        return MaterialPageRoute(builder: (_) => const SellerDetailsScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case Routes.contactUsScreen:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.white30,
                  body: Center(
                    child: AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Exit'),
                      content: const Text('Are you sure ?!!!!\nYou want to exit?'),
                      actions: [
                        AppTextButton(
                          buttonText: 'Yes',
                          textStyle: TextStyles.font12White,
                          onPressed: () {
                            exit(0);
                          },
                          buttonWidth: 30,
                          buttonHeight: 15,
                        ),
                        AppTextButton(
                          buttonText: 'No',
                          textStyle: TextStyles.font12White,
                          onPressed: () {
                            context.pushReplacementNamed(Routes.homeScreen);
                          },
                          buttonWidth: 30,
                          buttonHeight: 15,
                        ),
                      ],
                    ),
                  ),
                ));
    }
  }
}
