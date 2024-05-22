import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_drop_down_list.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class EditInfo extends StatelessWidget {
  const EditInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController governorateController = TextEditingController();
        TextEditingController cityController = TextEditingController();
        var cubit = CustomerCubit.get(context);
        // var model = cubit.userModel;
        // cubit.nameController.text = model!.data!.name!;
        // cubit.emailController.text = model.data!.email!;
        List<SelectedListItem> governorates = [
          SelectedListItem(name: 'Cairo'),
          SelectedListItem(name: 'Behira'),
          SelectedListItem(name: 'Giza'),
          SelectedListItem(name: 'Alex'),
          SelectedListItem(name: 'Dakahlia'),
          SelectedListItem(name: 'Banhaa'),
          SelectedListItem(name: 'Cairo'),
          SelectedListItem(name: 'Behira'),
          SelectedListItem(name: 'Giza'),
          SelectedListItem(name: 'Alex'),
          SelectedListItem(name: 'Dakahlia'),
          SelectedListItem(name: 'Banhaa'),
        ];
        List<SelectedListItem> cities = [
          SelectedListItem(name: 'Cairo'),
          SelectedListItem(name: 'Behira'),
          SelectedListItem(name: 'Giza'),
          SelectedListItem(name: 'Alex'),
          SelectedListItem(name: 'Dakahlia'),
          SelectedListItem(name: 'Banhaa'),
          SelectedListItem(name: 'Cairo'),
          SelectedListItem(name: 'Behira'),
          SelectedListItem(name: 'Giza'),
          SelectedListItem(name: 'Alex'),
          SelectedListItem(name: 'Dakahlia'),
          SelectedListItem(name: 'Banhaa'),
        ];
        return Container(
          color: Colors.white,
          child: Padding(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid name';
                      }
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid email';
                      }
                    },
                  ),
                  verticalSpace(20),
                  resuableText(
                    text: 'Mobile Phone',
                    fontsize: 17,
                    fontWeight: FontWeight.bold,
                  ),
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
                      CustomDropDownList(
                        prefixIcon: const Icon(
                          Icons.location_city_outlined,
                          color: ColorManager.mainOrange,
                        ),
                        dropedList: governorates,
                        textEditingController: governorateController,
                        title: 'Governorate',
                        hint: 'Governorate',
                        isCitySelected: true,
                      ),
                      verticalSpace(20),
                      CustomDropDownList(
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: ColorManager.mainOrange,
                        ),
                        dropedList: cities,
                        textEditingController: cityController,
                        title: 'City',
                        hint: 'City',
                        isCitySelected: true,
                      ),
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
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.updateUserData(
                          name: cubit.nameController.text,
                          email: cubit.emailController.text,
                          // phone: cubit.phoneController.text,
                        );
                      }
                    },
                  ),
                  verticalSpace(150),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
