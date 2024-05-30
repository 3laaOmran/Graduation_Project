import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/auth/login/logic/cubit/login_cubit.dart';
import 'package:two_way_dael/features/auth/signup/logic/cubit/siginup_cubit.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_button.dart';

class ForgetPasswordOtpScreen extends StatelessWidget {
  const ForgetPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // if (state is ConfirmPhoneNumberLoadingState) {
          //   CashHelper.getData(key: 'forgetPasswordToken');
          // }
          if (state is ConfirmPhoneNumberSuccessState) {
            if (state.confirmPhoneModel.status == 200) {
              showToast(
                message: state.confirmPhoneModel.message!,
                state: TostStates.SUCCESS,
              );
              context.pushNamed(Routes.forgetPasswordScreen);
            } else {
              showToast(
                message: state.confirmPhoneModel.message!,
                state: TostStates.ERROR,
              );
            }
          } else if (state is ConfirmPhoneNumberErrorState) {
            showToast(
              message: state.error,
              state: TostStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          var otpController = TextEditingController();
          final defaultPinTheme = PinTheme(
            width: 80,
            height: 80,
            textStyle: TextStyles.font30blackbold,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorManager.gray, width: 2),
            ),
          );

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.phoneForForgetPasswordScreen);
                          },
                          child: Image.asset(
                            'assets/images/arrow.png',
                            width: 60.w,
                          ),
                        ),
                        verticalSpace(50),
                        Text(
                          'Confirm Phone Number',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 30.0),
                        ),
                        verticalSpace(5),
                        Text(
                          'We\'ve sent you a code at ${cubit.phoneController.text}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        verticalSpace(45),
                        Text(
                          'Your Code',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  fontSize: 19.0, fontWeight: FontWeight.bold),
                        ),
                        verticalSpace(10),
                        Center(
                          child: AbsorbPointer(
                            absorbing: state is ConfirmPhoneNumberLoadingState?true:false,
                            child: Form(
                              key: cubit.otpFormKey,
                              child: Pinput(
                                controller: otpController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the code we sent you';
                                  }
                                  return null;
                                },
                                cursor: Container(
                                  width: 2,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                length: 4,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    color: ColorManager.mainOrange,
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  textStyle: defaultPinTheme.textStyle!.copyWith(
                                    color: Colors.white,
                                  ),
                                  decoration:
                                      defaultPinTheme.decoration!.copyWith(
                                    color: ColorManager.mainOrange,
                                  ),
                                ),
                                onCompleted: (value) {
                                  debugPrint(otpController.text);
                                },
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(15),
                        Text(
                          "Didn't receive anything?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 16.0),
                        ),
                        verticalSpace(25),
                        state is VerificationLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: ColorManager.mainOrange,
                              ))
                            : AppTextButton(
                                buttonText: 'Next',
                                textStyle: TextStyles.font20Whitebold,
                                onPressed: () {
                                  if (cubit.otpFormKey.currentState!
                                      .validate()) {
                                    cubit.confirmPhoneNumber(
                                      otp: otpController.text,
                                      token: forgetPasswordToken!,
                                    );
                                  }
                                },
                              ),
                        verticalSpace(15),
                        Center(
                          child: Text(
                            'By clicking "Next" you agree to our\nterms of service and privacy statement',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
