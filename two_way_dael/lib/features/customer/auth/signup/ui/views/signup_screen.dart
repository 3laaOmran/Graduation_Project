import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_snackbar.dart';
import 'package:two_way_dael/features/customer/auth/signup/logic/cubit/siginup_cubit.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/widgets/signup_and_login_footer.dart';
import '../widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            if (state.signupModel.status == 201) {
              // context.pushNamedAndRemoveUntil(Routes.otpScreen,predicate: (route) => false);
              showSnackBar(context, message: state.signupModel.message!);
              // showToast(
              //     message: state.signupModel.message!,
              //     state: TostStates.SUCCESS);
              CashHelper.saveData(
                      key: 'registerToken',
                      value: state.signupModel.data!.token)
                  .then((value) {
                registerToken = state.signupModel.data!.token;
                // CashHelper.getData(key: 'token');
                context.pushNamed(Routes.otpScreen);
              });
            } 
          } else if (state is SignupUsedEmailOrPhoneErrorState) {
            // showToast(
            //  message: state.error, state: TostStates.ERROR);
            showSnackBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          var cubit = SignupCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(20),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamedAndRemoveUntil(Routes.loginScreen,predicate: (route) => false);
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
                                  AbsorbPointer(
                                      absorbing: state is SignupLoadingState
                                          ? true
                                          : false,
                                      child: const SignupForm()),
                                  verticalSpace(30),
                                ],
                              ),
                              state is! SignupLoadingState
                                  ? AppTextButton(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      buttonText: "Sign Up",
                                      buttonWidth: width,
                                      onPressed: () {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.userSignup(
                                            email: cubit.emailController.text,
                                            name: cubit.nameController.text,
                                            phone: cubit.phoneController.text,
                                            password:
                                                cubit.passwordController.text,
                                          );
                                          // context.pushNamedAndRemoveUntil(
                                          //     Routes.otpScreen,
                                          //     predicate: (route) => false);
                                        }
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorManager.mainOrange,
                                      ),
                                    ),
                              verticalSpace(15),
                              SignupAndLoginFooter(
                                firstText: 'Already have an account ? ',
                                secondText: '  Login',
                                ontap: () {
                                  context.pushNamedAndRemoveUntil(Routes.loginScreen,predicate: (route) => false);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
