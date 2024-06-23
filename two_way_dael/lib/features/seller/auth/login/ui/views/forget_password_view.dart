import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/core/widgets/validation.dart';
import 'package:two_way_dael/features/seller/auth/login/logic/cubit/seller_login_cubit.dart';

class SellerForgetPasswordScreen extends StatelessWidget {
  const  SellerForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SellerLoginCubit(),
      child: BlocConsumer<SellerLoginCubit, SellerLoginStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            if (state.confirmPhoneModel.status == 200) {
              showToast(
                  message: state.confirmPhoneModel.message!,
                  state: TostStates.SUCCESS);
              context.pushReplacementNamed(Routes.sellerLoginScreen);
            } else {
              showToast(
                  message: state.confirmPhoneModel.message!,
                  state: TostStates.ERROR);
            }
          }else if (state is ChangePasswordErrorState) {
            showToast(
                message: state.error,
                state: TostStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SellerLoginCubit.get(context);
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main_background.png'),
                      fit: BoxFit.fill)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: AbsorbPointer(
                        absorbing:
                            state is ChangePasswordLoadingState ? true : false,
                        child: Form(
                          key: cubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(50),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamedAndRemoveUntil(Routes.sellerLoginScreen,predicate: (route) => false,);
                                },
                                child: Image.asset(
                                  'assets/images/arrow.png',
                                  width: 60.w,
                                ),
                              ),
                              verticalSpace(40),
                              Text(
                                "Forget Password",
                                style: TextStyles.font30blackbold,
                              ),
                              Text(
                                "Use a strong password for your safety",
                                style: TextStyles.font15BlackBold,
                              ),
                              verticalSpace(30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  resuableText(
                                      text: "New Password", fontsize: 17.sp),
                                  CustomTextFormField(
                                    prefixIcon: const Icon(Icons.lock),
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: "New Password",
                                    controller: cubit.forgetPasswordController,
                                    isObsecureText: cubit.isObsecure,
                                    sufixIcon: cubit.suffixIcon,
                                    suffixOnPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
                                    validator: passwordValidation,
                                  ),
                                  verticalSpace(30),
                                  resuableText(
                                      text: "Confirm Password",
                                      fontsize: 17.sp),
                                  CustomTextFormField(
                                    prefixIcon: const Icon(Icons.lock),
                                    keyboardType: TextInputType.visiblePassword,
                                    hintText: "Confirm Password",
                                    controller: cubit.confirmPasswordController,
                                    isObsecureText: cubit.confirmIsObsecure,
                                    sufixIcon: cubit.confirmSuffixIcon,
                                    suffixOnPressed: () {
                                      cubit.changeConfirmPasswordVisibility();
                                    },
                                    validator: passwordValidation,
                                  ),
                                  verticalSpace(60),
                                ],
                              ),
                              state is! ChangePasswordLoadingState
                                  ? AppTextButton(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      buttonText: "Confirm",
                                      buttonWidth: width,
                                      onPressed: () {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.changePassword(
                                            password: cubit
                                                .forgetPasswordController.text,
                                            passwordConfirmation: cubit
                                                .confirmPasswordController.text,
                                            token: forgetPasswordTokenSeller!,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
