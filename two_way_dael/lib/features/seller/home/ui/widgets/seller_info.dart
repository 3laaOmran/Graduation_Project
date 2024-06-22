import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class SellerEditInfo extends StatelessWidget {
  const SellerEditInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        // if (state is GetUserDataSuccessState) {}
      },
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        var model = cubit.sellerDataModel;
        cubit.nameController.text = model!.data!.name!;
        cubit.emailController.text = model.data!.email!;
        cubit.phoneController.text = model.data!.phone!;
        cubit.addressController.text = model.data!.address!;
        cubit.joinDateController.text = model.data!.joinedFrom!;
        cubit.verifiedController.text = model.data!.verifiedFrom!;
        // cubit.yourSalesController.text = model.data!.sales!;

        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Profile',
                    style: TextStyles.font20blackbold,
                  ),
                  verticalSpace(30),
                  resuableText(
                    text: 'User Name:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.person),
                    controller: cubit.nameController,
                    isObsecureText: false,
                    keyboardType: TextInputType.text,
                    hintText: 'Name',
                    enabled: false,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Email Address:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    controller: cubit.emailController,
                    isObsecureText: false,
                    hintText: 'Email Address',
                    enabled: false,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Mobile Phone:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                    isObsecureText: false,
                    hintText: 'Phone',
                    enabled: false,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Address:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    controller: cubit.addressController,
                    prefixIcon: const Icon(Icons.map),
                    isObsecureText: false,
                    hintText: 'Address',
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Joiened From:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    controller: cubit.joinDateController,
                    prefixIcon: const Icon(Icons.calendar_month),
                    isObsecureText: false,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Verified From:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    controller: cubit.verifiedController,
                    prefixIcon: const Icon(Icons.calendar_month),
                    isObsecureText: false,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Your Sales:',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    controller: cubit.yourSalesController,
                    prefixIcon: const Icon(Icons.money),
                    isObsecureText: false,
                  ),
                  verticalSpace(20),
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
                      context.pushNamed(Routes.sellerChangePasswordScreen);
                    },
                  ),
                  verticalSpace(120),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
