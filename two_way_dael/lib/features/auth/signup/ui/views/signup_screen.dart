import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/signup_and_login_footer.dart';
import '../widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration:const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // context.pushNamed(Routes.chooseAccounttypeScreen);
                        },
                        child: Image.asset(
                          'assets/images/arrow.png',
                          width: 60.w,
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 30.sp,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Create a new account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SignupForm(),
                          verticalSpace(30),
                          // const SignupBlocListener(),
                        ],
                      ),
                      AppTextButton(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        buttonText: "Sign Up",
                        buttonWidth: width,
                        onPressed: () {
                          context.pushNamedAndRemoveUntil(Routes.homeScreen,
                              predicate: (route) => false);
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, Routes.homeScreen, (route) => false);
                          // context.pushNamed(Routes.homeScreen);
                          // validateThenDoSignup(context);
                        },
                      ),
                      verticalSpace(40),
                    ],
                  ),
                ),
                SignupAndLoginFooter(
                  firstText: 'Already have an account ? ',
                  secondText: '  Login',
                  ontap: () {
                    context.pushNamed(Routes.loginScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void validateThenDoSignup(BuildContext context) {
  //   if (context.read<SignupCubit>().formKey.currentState!.validate()) {
  //     context.read<SignupCubit>().emitSignupStates();
  //   }
  // }
}
