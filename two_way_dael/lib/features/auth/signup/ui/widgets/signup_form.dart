import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../core/helpers/app_regex.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // passwordController = context.read<SignupCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: context.read<SignupCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resuableText(
            text: "Name",
            fontsize: 17.sp,
          ),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
            hintText: "Name",
            // controller: context.read<SignupCubit>().nameController,
            isObsecureText: false,
            prefixIcon: const Icon(Icons.person),
          ),
          verticalSpace(15),
          resuableText(
            text: "Email Address",
            fontsize: 17.sp,
          ),
          CustomTextFormField(
            hintText: "Email Address",
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
            },
            // controller: context.read<SignupCubit>().emailController,
            isObsecureText: false,
            prefixIcon: const Icon(Icons.email),
            
          ),
          verticalSpace(15),
          resuableText(text: "Phone", fontsize: 17.sp),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            hintText: "Phone",
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid phone number';
              }
            },
            // controller: context.read<SignupCubit>().phoneController,
            isObsecureText: false,
            prefixIcon: const Icon(Icons.phone),
            
          ),
          verticalSpace(15),
          resuableText(text: "Password", fontsize: 17.sp),
          CustomTextFormField(
            // controller: context.read<SignupCubit>().passwordController,
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            isObsecureText: isPasswordObscureText,
            sufixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          // verticalSpace(15),
          
          verticalSpace(20),
          // PasswordValidation(
          //   hasLowerCase: hasLowercase,
          //   hasUpperCase: hasUppercase,
          //   hasSpecialCharacter: hasSpecialCharacters,
          //   hasNumber: hasNumber,
          //   hasMinLength: hasMinLength,
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
