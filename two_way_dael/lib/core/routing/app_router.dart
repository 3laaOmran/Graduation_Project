import 'package:flutter/material.dart';
import 'package:two_way_dael/core/routing/routes.dart';

import '../../features/auth/login/ui/views/login_screen.dart';
import '../../features/auth/signup/ui/views/signup_screen.dart';
import '../../features/home/ui/views/home_screen.dart';
import '../../features/onboarding/views/onboarding_screen.dart';


class AppRouter {
  Route generateRoure(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) =>  LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const CustomerLayoutScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route for ${settings.name}'),
                  ),
                ));
    }
  }
}
