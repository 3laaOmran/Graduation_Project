import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_snackbar.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/core/widgets/signup_and_login_footer.dart';
import 'package:two_way_dael/features/customer/auth/login/logic/cubit/login_cubit.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/widgets/resuable_text.dart';
import '../widgets/email_and_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //height of screen
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == 200) {
              showToast(
                  message: state.loginModel.message!,
                  state: TostStates.SUCCESS);
              // showSnackBar(context, message: state.loginModel.message!);
              CashHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                context.pushNamedAndRemoveUntil(Routes.homeScreen,
                    predicate: (route) => false);
              });
            }
          } else if (state is LoginUnauthorizedState) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.error)),
            // );
            // if (state is LoginUnauthorizedState) {
            // showToast(message: state.error, state: TostStates.ERROR);
            // }
            showSnackBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
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
                            verticalSpace(80),
                            GestureDetector(
                              onTap: () {
                                context.pushNamedAndRemoveUntil(
                                  Routes.chooseAccountTypeScreen,
                                  predicate: (route) => false,
                                );
                              },
                              child: Image.asset(
                                'assets/images/arrow.png',
                                width: 60.w,
                              ),
                            ),
                            verticalSpace(50),
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
                                AbsorbPointer(
                                    absorbing: state is LoginLoadingState
                                        ? true
                                        : false,
                                    child: const EmailAndPassword()),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushNamedAndRemoveUntil(
                                          Routes.phoneForForgetPasswordScreen,
                                          predicate: (route) => false);
                                    },
                                    child: resuableText(
                                        text: "Forget Password?",
                                        fontsize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.mainOrange),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(12),
                            state is! LoginLoadingState
                                ? AppTextButton(
                                    buttonText: "Log in",
                                    verticalPadding: 10,
                                    buttonWidth: width,
                                    textStyle: TextStyles.font18White,
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.userLogin(
                                          email: cubit.emailController.text,
                                          password:
                                              cubit.passwordController.text,
                                        );
                                      }
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorManager.mainOrange,
                                    ),
                                  ),
                            verticalSpace(20),
                            SignupAndLoginFooter(
                                firstText: "Don't have account ?? ",
                                secondText: "SignUp",
                                ontap: () {
                                  context.pushNamedAndRemoveUntil(
                                      Routes.signupScreen,
                                      predicate: (route) => false);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
