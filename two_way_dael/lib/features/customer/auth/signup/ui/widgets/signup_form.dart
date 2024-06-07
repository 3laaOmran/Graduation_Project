import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/core/widgets/validation.dart';
import 'package:two_way_dael/features/customer/auth/signup/logic/cubit/siginup_cubit.dart';

import '../../../../../../../core/helpers/spacing.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        var cubit = SignupCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              resuableText(
                text: "Name",
                fontsize: 17.sp,
              ),
              CustomTextFormField(
                keyboardType: TextInputType.name,
                validator: nameValidation,
                hintText: "Name",
                controller: cubit.nameController,
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
                keyboardType: TextInputType.emailAddress,
                validator: emailValidation,
                controller: cubit.emailController,
                isObsecureText: false,
                prefixIcon: const Icon(Icons.email),
              ),
              verticalSpace(15),
              resuableText(text: "Phone", fontsize: 17.sp),
              CustomTextFormField(
                keyboardType: TextInputType.phone,
                hintText: "Phone",
                validator: phoneNumberValidation,
                controller: cubit.phoneController,
                isObsecureText: false,
                prefixIcon: const Icon(Icons.phone),
              ),
              verticalSpace(15),
              resuableText(text: "Password", fontsize: 17.sp),
              CustomTextFormField(
                onFieldSubmitted: (value) {
                  cubit.formKey.currentState!.validate();
                },
                prefixIcon: const Icon(Icons.lock),
                keyboardType: TextInputType.visiblePassword,
                hintText: "Password",
                controller: cubit.passwordController,
                isObsecureText: cubit.isObsecure,
                sufixIcon: cubit.suffixIcon,
                suffixOnPressed: () {
                  cubit.changePasswordVisibility();
                },
                validator: passwordValidation,
              ),
              verticalSpace(10),
            ],
          ),
        );
      },
    );
  }
}
