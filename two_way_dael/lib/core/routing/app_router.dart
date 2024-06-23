import 'dart:io';
import 'package:flutter/material.dart';
import 'package:two_way_dael/choose_account_type_screen.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/auth/login/ui/views/forget_password_otp_screen.dart';
import 'package:two_way_dael/features/customer/auth/login/ui/views/forget_password_view.dart';
import 'package:two_way_dael/features/customer/auth/login/ui/views/phone_for_forget_password.dart';
import 'package:two_way_dael/features/customer/auth/signup/ui/views/otp_screen.dart';
import 'package:two_way_dael/features/customer/auth/signup/ui/views/photo_and_address_screen.dart';
import 'package:two_way_dael/features/customer/auth/signup/ui/views/customer_welcome_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/about_app.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/cart_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/contact_us_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/favorite_sellers.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/notifications_module.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/search_module.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/seller_details.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/your_orders_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/change_password_screen.dart';
import 'package:two_way_dael/features/seller/auth/login/ui/views/forget_password_otp_screen.dart';
import 'package:two_way_dael/features/seller/auth/login/ui/views/forget_password_view.dart';
import 'package:two_way_dael/features/seller/auth/login/ui/views/phone_for_forget_password.dart';
import 'package:two_way_dael/features/seller/auth/login/ui/views/seller_login_screen.dart';
import 'package:two_way_dael/features/seller/auth/signup/ui/views/seller_certificates.dart';
import 'package:two_way_dael/features/seller/auth/signup/ui/views/seller_otp_screen.dart';
import 'package:two_way_dael/features/seller/auth/signup/ui/views/seller_photo_and_address_screen.dart';
import 'package:two_way_dael/features/seller/auth/signup/ui/views/seller_signup_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/add_product.dart';
import 'package:two_way_dael/features/seller/home/ui/views/donation_module.dart';
import 'package:two_way_dael/features/seller/home/ui/views/new_orders.dart';
import 'package:two_way_dael/features/seller/home/ui/views/seller_home_screen.dart';
import 'package:two_way_dael/features/seller/home/ui/views/seller_notifications_module.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/seller_change_password.dart';
import '../../features/customer/auth/login/ui/views/login_screen.dart';
import '../../features/customer/auth/signup/ui/views/signup_screen.dart';
import '../../features/customer/home/ui/views/home_screen.dart';
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
        return MaterialPageRoute(builder: (_) => const FavoriteSellers());
      case Routes.sellerDeatailsScreen:
        return MaterialPageRoute(builder: (_) => const SellerDetailsScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case Routes.contactUsScreen:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case Routes.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.customerwelcomeScreen:
        return MaterialPageRoute(builder: (_) => const CustomerWelcomeScreen());
      case Routes.chooseAccountTypeScreen:
        return MaterialPageRoute(
            builder: (_) => const ChooseAccountTypeScreen());
      case Routes.sellerLoginScreen:
        return MaterialPageRoute(builder: (_) => const SellerLoginScreen());
      case Routes.sellerHomeScreen:
        return MaterialPageRoute(builder: (_) => const SellerHomeScreen());
      case Routes.sellerSignupScreen:
        return MaterialPageRoute(builder: (_) => const SellerSignupScreen());
      case Routes.sellerOtpScreen:
        return MaterialPageRoute(builder: (_) => const SellerConfirmAccount());
      case Routes.sellerPhotoAndAddressScreen:
        return MaterialPageRoute(
            builder: (_) => const SellerPhotoAndAddressScreen());
      case Routes.sellerCirtificates:
        return MaterialPageRoute(builder: (_) => const SellerCertificates());
      case Routes.sellerNotificationsScreen:
        return MaterialPageRoute(
            builder: (_) => const SellerNotificationsModule());
      case Routes.sellerAddNewProduct:
        return MaterialPageRoute(builder: (_) => const AddProduct());
      case Routes.sellerDonationScreen:
        return MaterialPageRoute(builder: (_) => const SellerDonationScreen());
      case Routes.sellerNewOrdersScreen:
        return MaterialPageRoute(builder: (_) => const NewOrdersScreen());
      case Routes.sellerChangePasswordScreen:
        return MaterialPageRoute(builder: (_) => const SellerChangePasswordScreen());
      case Routes.sellerPhoneForForgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const SellerPhoneForForgetPasswordScreen());
      case Routes.sellerPhoneForForgetPasswordChangeScreen:
        return MaterialPageRoute(builder: (_) => const SellerForgetPasswordScreen());
      case Routes.sellerPhoneForForgetPasswordOtpScreen:
        return MaterialPageRoute(builder: (_) => const SellerForgetPasswordOtpScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.white30,
                  body: Center(
                    child: AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Exit'),
                      content:
                          const Text('Are you sure ?!!!!\nYou want to exit?'),
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
                            token != null
                                ? context
                                    .pushReplacementNamed(Routes.homeScreen)
                                : sellerToken != null
                                    ? context.pushReplacementNamed(
                                        Routes.sellerHomeScreen)
                                    : context.pushReplacementNamed(
                                        Routes.chooseAccountTypeScreen);
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
