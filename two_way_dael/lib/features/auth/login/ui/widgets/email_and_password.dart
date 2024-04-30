import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';

import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/resuable_text.dart';


class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObsecureText = true;
  final TextEditingController passwordController = TextEditingController();
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasMinLenght = false;

  @override
  void initState() {
    super.initState();
    // passwordControler = context.read<LoginCubit>().passwordControler;
    SetupPasswordControllerListener();
  }

  void SetupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(passwordController.text);
        hasUpperCase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacter =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLenght = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: context.read<LoginCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resuableText(text: "Email Address", fontsize: 17.sp),
          CustomTextFormField(
            hintText: "Email Address",
            isObsecureText: false,
            prefixIcon: Icon(Icons.email),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter valid email';
              }
            },
            // controller: context.read<LoginCubit>().emailControler,
          ),
          verticalSpace(20),
          resuableText(text: "Password", fontsize: 17.sp),
          CustomTextFormField(
            prefixIcon: Icon(Icons.lock),
            hintText: "Password",
            // controller: context.read<LoginCubit>().passwordControler,
            isObsecureText: isObsecureText,
            sufixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObsecureText = !isObsecureText;
                });
              },
              child: Icon(
                isObsecureText ? Icons.visibility_off : Icons.visibility,
                color: ColorManager.mainOrange,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid password';
              }
            },
          ),
          verticalSpace(20),
          // PasswordValidation(
          //   hasLowerCase: hasLowerCase,
          //   hasUpperCase: hasUpperCase,
          //   hasMinLength: hasMinLenght,
          //   hasNumber: hasNumber,
          //   hasSpecialCharacter: hasSpecialCharacter,
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
