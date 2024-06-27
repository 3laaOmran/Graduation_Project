import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/customer/auth/login/logic/cubit/login_cubit.dart';
import 'package:two_way_dael/core/widgets/validation.dart';

import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/widgets/resuable_text.dart';

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              resuableText(text: "Email Address", fontsize: 17.sp),
              CustomTextFormField(
                isObsecureText: false,
                hintText: "Email Address",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                validator: emailValidation,
                controller: cubit.emailController,
              ),
              verticalSpace(20),
              resuableText(text: "Password", fontsize: 17.sp),
              CustomTextFormField(
                onFieldSubmitted: (value) {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.userLogin(
                      email: cubit.emailController.text,
                      password: cubit.passwordController.text,
                    );
                  }
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
                // validator: passwordValidation,
              ),
              verticalSpace(20),
            ],
          ),
        );
      },
    );
  }
}
