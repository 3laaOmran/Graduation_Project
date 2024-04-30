import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_floating_action_button.dart';
import '../../../../../core/widgets/resuable_text.dart';
import '../../../../../core/widgets/signup_and_login_footer.dart';
import '../widgets/email_and_password.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //height of screen
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/main_background.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(50),
                    GestureDetector(
                      onTap: () {
                        // context.pushNamed(Routes.chooseAccounttypeScreen);
                      },
                      child: Image.asset(
                        'assets/images/arrow.png',
                        width: 60.w,
                      ),
                    ),
                    verticalSpace(30),
                    resuableText(
                        text: "Login Now  ",
                        fontsize: 30.sp,
                        letterspacing: 2,
                        fontWeight: FontWeight.bold),
                    resuableText(
                        text: "Welcome Back",
                        fontsize: 17.sp,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const EmailAndPassword(),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: resuableText(
                              text: "Forget The Password?",
                              fontsize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.mainOrange),
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    AppTextButton(
                      buttonText: "Log in",
                      buttonWidth: width,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      onPressed: () {
                        // validateThenLogin(context);
                      },
                     
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Center(
                      child: floatingactionButton(
                          width, height, "google_image", "logingoogle"),
                    ),
                    verticalSpace(80),
                  ],
                ),
              ),
              SignupAndLoginFooter(
                  firstText: "Don't have account ?? ",
                  secondText: "SignUp",
                  ontap: () {
                    context.pushNamed(Routes.signupScreen);
                  }),
              // const LoginBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  // void validateThenLogin(BuildContext context) {
  //   if (context.read<LoginCubit>().formKey.currentState!.validate()) {
  //     context.read<LoginCubit>().emitLoginStates();
  //   }
  // }
}
