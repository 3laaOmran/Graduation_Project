import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

void showBottomSheetMethod(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => BlocBuilder<SellerCubit, SellerStates>(
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: cubit.donateFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(15),
                  Text(
                    'Donation Details',
                    style: TextStyles.font17BlackBold,
                  ),
                  verticalSpace(5),
                  CustomTextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please Enter Donation Details';
                      }
                      return null;
                    },
                    controller: cubit.detailsController,
                    keyboardType: TextInputType.text,
                    isObsecureText: false,
                    hintText: 'All Your Donation Details',
                    maxLines: 5,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  verticalSpace(15),
                  Text(
                    'Donation Amount',
                    style: TextStyles.font17BlackBold,
                  ),
                  verticalSpace(5),
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please Enter Amount';
                      }
                      return null;
                    },
                    controller: cubit.amountController,
                    isObsecureText: false,
                    hintText: 'Donation Amount',
                    borderRadius: BorderRadius.circular(10),
                  ),
                  verticalSpace(30),
                  AppTextButton(
                    buttonText: 'Send Donation Request',
                    textStyle: TextStyles.font18White,
                    onPressed: () {
                      if (cubit.donateFormKey.currentState!.validate()) {
                        showToast(
                          message:
                              'The request has been sent successfully. Check your email to see their answer.',
                          state: TostStates.SUCCESS,
                        );
                        context.pop();
                        cubit.detailsController.clear();
                        cubit.amountController.clear();
                      }
                    },
                  ),
                  verticalSpace(15),
                  AppTextButton(
                    buttonText: 'Cancel',
                    textStyle: TextStyles.font18White.copyWith(
                      color: ColorManager.mainOrange,
                    ),
                    backgroundColor: Colors.white,
                    borderSide: const BorderSide(
                      width: 2,
                      color: ColorManager.mainOrange,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
