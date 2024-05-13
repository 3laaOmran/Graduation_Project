import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../auth/signup/ui/widgets/build_drop_down_list.dart';

class EditInfo extends StatelessWidget {
  const EditInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var model = cubit.userModel;
        cubit.nameController.text = model!.data!.name!;
        cubit.emailController.text = model.data!.email!;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state is CustomerUpdateProfileLoadingState
                    ? const LinearProgressIndicator(
                        color: ColorManager.mainOrange,
                      )
                    : Text(
                        'Edit Info',
                        style: TextStyles.font20blackbold,
                      ),
                verticalSpace(30),
                CustomTextFormField(
                  prefixIcon: const Icon(Icons.person),
                  controller: cubit.nameController,
                  isObsecureText: false,
                  keyboardType: TextInputType.text,
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid name';
                    }
                  },
                ),
                verticalSpace(20),
                CustomTextFormField(
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  isObsecureText: false,
                  hintText: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                  },
                ),
                verticalSpace(20),
                CustomTextFormField(
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  isObsecureText: false,
                  hintText: 'Phone',
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return 'Please enter a valid phone number';
                    // }
                  },
                ),
                verticalSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDropDownList(
                      list: ['Cairo', 'Alex', 'Behira', 'Giza'],
                      selectedItem: 'Cairo',
                    ),
                    verticalSpace(15),
                    buildDropDownList(
                      list: ['Abohommos', 'Damanhoor', 'Nobaria'],
                      selectedItem: 'Abohommos',
                    ),
                  ],
                ),
                verticalSpace(15),
                AppTextButton(
                  buttonText: 'Change Password',
                  textStyle: const TextStyle(
                    color: ColorManager.mainOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.white,
                  borderSide: const BorderSide(
                    width: 2,
                    color: ColorManager.mainOrange,
                  ),
                  onPressed: () {
                    // context.pushNamed(Routes.otpScreen);
                  },
                ),
                verticalSpace(20),
                AppTextButton(
                  buttonText: 'Save',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.updateUserData(
                        name: cubit.nameController.text,
                        email: cubit.emailController.text,
                        // phone: cubit.phoneController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
