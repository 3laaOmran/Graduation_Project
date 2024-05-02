import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

Widget editInfo() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Info',
          style: TextStyles.font20blackbold,
        ),
        verticalSpace(30),
        CustomTextFormField(
          hintText: 'Name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid name';
            }
          },
        ),
        verticalSpace(20),
        CustomTextFormField(
          hintText: 'Email Address',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid email';
            }
          },
        ),
        verticalSpace(20),
        CustomTextFormField(
          hintText: 'Phone',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid phone number';
            }
          },
        ),
        verticalSpace(20),
        CustomTextFormField(
          hintText: 'Password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid password';
            }
          },
        ),
        verticalSpace(20),
        CustomTextFormField(
          hintText: 'Address',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
          },
        ),
        verticalSpace(20),
        AppTextButton(
          buttonText: 'Save',
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}