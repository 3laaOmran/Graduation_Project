import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/auth/login/logic/cubit/login_cubit.dart';

class PhoneForForgetPasswordScreen extends StatelessWidget {
  const PhoneForForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(50),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(Routes.loginScreen);
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
                            CustomTextFormField(
                              keyboardType: TextInputType.phone,
                              hintText: "Phone",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                              },
                              controller: cubit.phoneController,
                              isObsecureText: false,
                              prefixIcon: const Icon(Icons.phone),
                            ),
                            verticalSpace(60),
                            AppTextButton(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              buttonText: "Next",
                              buttonWidth: width,
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  context.pushNamed(Routes.forgetPasswordOtpScreen);
                                }
                              },
                            ),
                            verticalSpace(15),
                          ],
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
