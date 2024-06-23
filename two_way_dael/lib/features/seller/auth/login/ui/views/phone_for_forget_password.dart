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

class SellerPhoneForForgetPasswordScreen extends StatelessWidget {
  const SellerPhoneForForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SellerLoginCubit(),
      child: BlocConsumer<SellerLoginCubit, SellerLoginStates>(
        listener: (context, state) {
          if (state is PhoneForgetPasswordSuccessState) {
            if (state.loginModel.status == 200) {
              context.pushNamedAndRemoveUntil(Routes.sellerPhoneForForgetPasswordOtpScreen,predicate: (route) => false,);
              showToast(
                  message: state.loginModel.message!,
                  state: TostStates.SUCCESS);
              forgetPasswordTokenSeller = state.loginModel.data!.token;
            } else {
              showToast(
                  message: state.loginModel.message!, state: TostStates.ERROR);
            }
          } else if (state is PhoneForgetPasswordErrorState) {
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
                            "Phone Number",
                            style: TextStyles.font30blackbold,
                          ),
                          Text(
                            "Enter your phone number",
                            style: TextStyles.font15BlackBold,
                          ),
                          verticalSpace(30),
                          resuableText(text: "Phone", fontsize: 17.sp),
                          AbsorbPointer(
                            absorbing: state is PhoneForgetPasswordLoadingState?true:false,
                            child: Form(
                              key: cubit.formKey,
                              child: CustomTextFormField(
                                keyboardType: TextInputType.phone,
                                hintText: "Phone",
                                validator: phoneNumberValidation,
                                controller: cubit.phoneController,
                                isObsecureText: false,
                                prefixIcon: const Icon(Icons.phone),
                              ),
                            ),
                          ),
                          verticalSpace(60),
                          state is! PhoneForgetPasswordLoadingState
                              ? AppTextButton(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  buttonText: "Next",
                                  buttonWidth: width,
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.checkPhoneNumber(
                                        phone: cubit.phoneController.text,
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
