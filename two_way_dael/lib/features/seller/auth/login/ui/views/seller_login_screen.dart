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
import 'package:two_way_dael/features/seller/auth/login/logic/cubit/seller_login_cubit.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/widgets/resuable_text.dart';
import '../widgets/seller_email_and_password.dart';

class SellerLoginScreen extends StatelessWidget {
  const SellerLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //height of screen
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SellerLoginCubit(),
      child: BlocConsumer<SellerLoginCubit, SellerLoginStates>(
        listener: (context, state) {
          if (state is SellerLoginSuccessState) {
            if (state.loginModel.status == 200) {
              // showSnackBar(context, message: state.loginModel.message!);
              showToast(
                  message: state.loginModel.message!,
                  state: TostStates.SUCCESS);
              CashHelper.saveData(
                      key: 'sellerToken', value: state.loginModel.data!.token)
                  .then((value) {
                sellerToken = state.loginModel.data!.token;
                context.pushNamedAndRemoveUntil(Routes.sellerHomeScreen,
                    predicate: (route) => false);
              });
            }
          } else if (state is SellerLoginUnauthorizedState) {
            // showToast(
            //     message: state.error, state: TostStates.ERROR);
            showSnackBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          var cubit = SellerLoginCubit.get(context);
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
                                    predicate: (route) => false);
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
                                text: "Welcome Back To Your Business",
                                fontsize: 19.sp,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              height: height * 0.06,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AbsorbPointer(
                                    absorbing: state is SellerLoginLoadingState
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
                                      context.pushNamedAndRemoveUntil(Routes
                                          .sellerPhoneForForgetPasswordScreen,predicate: (route) => false);
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
                            state is! SellerLoginLoadingState
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
                                      Routes.sellerSignupScreen,
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
