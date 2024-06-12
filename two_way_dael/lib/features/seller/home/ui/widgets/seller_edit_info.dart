import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/core/widgets/validation.dart';
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
        // cubit.governorateController.text = model.data!.governorate!;
        // cubit.cityController.text = model.data!.city!;

        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              // key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // state is CustomerUpdateProfileLoadingState
                  //     ? const LinearProgressIndicator(
                  //         color: ColorManager.mainOrange,
                  //       )
                  //     :
                  Text(
                    'Edit Profile',
                    style: TextStyles.font20blackbold,
                  ),
                  verticalSpace(30),
                  resuableText(
                    text: 'User Name',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.person),
                    controller: cubit.nameController,
                    isObsecureText: false,
                    keyboardType: TextInputType.text,
                    hintText: 'Name',
                    validator: nameValidation,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Email Address',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    controller: cubit.emailController,
                    isObsecureText: false,
                    hintText: 'Email Address',
                    validator: emailValidation,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Mobile Phone',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                    isObsecureText: false,
                    hintText: 'Phone',
                    validator: phoneNumberValidation,
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Address',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormField(
                    enabled: false,
                    controller: cubit.addressController,
                    prefixIcon: const Icon(Icons.map),
                    keyboardType: TextInputType.name,
                    isObsecureText: false,
                    hintText: 'Address',
                    borderRadius: BorderRadius.circular(25),
                    // validator: phoneNumberValidation,
                  ),
                  verticalSpace(20),
                  // ignore: prefer_const_constructors
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // CustomDropDownList(
                      //   selectedItems: (List<dynamic> selectedList) {
                      //     for (var item in selectedList) {
                      //       if (item is SelectedListItem) {
                      //         cubit.governorateController.text = item.name;
                      //         cubit.selectedGovernorateId =
                      //             cubit.governoratesList.indexOf(item) + 1;
                      //         cubit.getCities(cubit.selectedGovernorateId);
                      //         cubit.cityController.text = '';
                      //         cubit.selectedCityId = null;
                      //       }
                      //     }
                      //   },
                      //   validation: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Governorate is required';
                      //     }
                      //     return null;
                      //   },
                      //   prefixIcon: const Icon(
                      //     Icons.location_city_outlined,
                      //     color: ColorManager.mainOrange,
                      //   ),
                      //   dropedList: cubit.governoratesList,
                      //   textEditingController: cubit.governorateController,
                      //   title: 'Governorate',
                      //   hint: 'Governorate',
                      //   isCitySelected: true,
                      // ),
                      // verticalSpace(20),
                      // CustomDropDownList(
                      //   selectedItems: (List<dynamic> selectedList) {
                      //     for (var item in selectedList) {
                      //       if (item is SelectedListItem) {
                      //         cubit.cityController.text = item.name;
                      //         cubit.selectedCityId =
                      //             cubit.selectedCities.indexOf(item) + 1;
                      //       }
                      //     }
                      //   },
                      //   validation: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'City is required';
                      //     }
                      //     return null;
                      //   },
                      //   prefixIcon: const Icon(
                      //     Icons.location_on,
                      //     color: ColorManager.mainOrange,
                      //   ),
                      //   dropedList: cubit.selectedCities,
                      //   textEditingController: cubit.cityController,
                      //   title: 'City',
                      //   hint: 'City',
                      //   isCitySelected: true,
                      // ),
                    ],
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
                      context.pushNamed(Routes.changePasswordScreen);
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
                      // if (cubit.formKey.currentState!.validate()) {
                      //   // cubit.updateUserData(
                      //   //   name: cubit.nameController.text,
                      //   //   email: cubit.emailController.text,
                      //   //   // phone: cubit.phoneController.text,
                      //   // );
                      // }
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
