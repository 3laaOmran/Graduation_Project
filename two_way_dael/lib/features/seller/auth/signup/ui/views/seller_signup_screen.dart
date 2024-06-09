import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_snackbar.dart';
import 'package:two_way_dael/features/seller/auth/signup/logic/cubit/seller_signup_cubit.dart';
import 'package:two_way_dael/features/seller/auth/signup/ui/widgets/seller_signup_form.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/widgets/signup_and_login_footer.dart';

class SellerSignupScreen extends StatelessWidget {
  const SellerSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SellerSignupCubit(),
      child: BlocConsumer<SellerSignupCubit, SellerSignupStates>(
        listener: (context, state) {
          if (state is SellerSignupSuccessState) {
            if (state.signupModel.status == 201) {
              // context.pushNamed(Routes.sellerHomeScreen);
              // showToast(
              //     message: state.signupModel.message!,
              //     state: TostStates.SUCCESS);
              showSnackBar(context, message: state.signupModel.message!);
              CashHelper.saveData(
                      key: 'sellerRegisterToken',
                      value: state.signupModel.data!.token)
                  .then((value) {
                sellerRegisterToken = state.signupModel.data!.token;
                context.pushNamed(Routes.sellerOtpScreen);
              });
            } 
          } else if (state is SellerSignupUsedEmailOrPhoneErrorState) {
            // showToast(
            //  message: state.error, state: TostStates.ERROR);
            showSnackBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          var cubit = SellerSignupCubit.get(context);
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
                                  context.pushNamedAndRemoveUntil(
                                      Routes.sellerLoginScreen,
                                      predicate: (route) => false);
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
                                "Start Your Business",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              verticalSpace(30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AbsorbPointer(
                                      absorbing:
                                          state is SellerSignupLoadingState
                                              ? true
                                              : false,
                                      child: const SellerSignupForm()),
                                  verticalSpace(30),
                                ],
                              ),
                              state is! SellerSignupLoadingState
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
                                  context.pushNamedAndRemoveUntil(
                                      Routes.sellerLoginScreen,
                                      predicate: (route) => false);
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
