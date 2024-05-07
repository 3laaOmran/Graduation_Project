import 'dart:io';

import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/features/auth/login/ui/views/forget_password_otp_screen.dart';
import 'package:two_way_dael/features/auth/login/ui/views/forget_password_view.dart';
import 'package:two_way_dael/features/auth/login/ui/views/phone_for_forget_password.dart';
import 'package:two_way_dael/features/auth/signup/ui/views/otp_screen.dart';
import 'package:two_way_dael/features/auth/signup/ui/views/photo_and_address_screen.dart';
import 'package:two_way_dael/features/home/ui/Modules/about_app.dart';
import 'package:two_way_dael/features/home/ui/Modules/donation_module.dart';
import 'package:two_way_dael/features/home/ui/Modules/favorite_sellers.dart';
import 'package:two_way_dael/features/home/ui/Modules/notifications_module.dart';
import 'package:two_way_dael/features/home/ui/Modules/your_orders_screen.dart';

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
      case Routes.donationScreen:
        return MaterialPageRoute(builder: (_) => const DonationScreen());
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
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: Colors.white30,
              body: Center(
                child: AlertDialog(
                  backgroundColor: Colors.white,
                      title: const Text('Exit'),
                      content: const Text('Do you want to exit?'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              exit(0);
                            },
                            child: const Text('Yes')),
                        ElevatedButton(
                            onPressed: () {
                              context.pushReplacementNamed(Routes.homeScreen);
                            },
                            child: const Text('No')),
                      ],
                    ),
              ),
            ));
    }
  }
}
