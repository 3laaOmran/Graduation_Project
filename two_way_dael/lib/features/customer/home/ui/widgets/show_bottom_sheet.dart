import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_charity_item.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

void showBottomSheetMethod(context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(30),
          topEnd: Radius.circular(30),
        ),
      ),
      child: BlocBuilder<CustomerCubit, CustomerStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: CustomerCubit.get(context).charities.length,
                  //   itemBuilder: (context, index) => ListTile(
                  //     title: CustomerCubit.get(context).charities[index],
                  //   ),
                  //   separatorBuilder: (context, index) => Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  //     child: Container(
                  //       width: double.infinity,
                  //       height: 1.5,
                  //       color: Colors.grey[300],
                  //     ),
                  //   ),
                  // ),
                  BuildCharityItem(
                    charityItemModel: CharityItemModel(
                      image: 'assets/images/MisrElkhair.png',
                      name: 'Misr EL-Khair',
                      value: 796,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextButton(
                          buttonText: 'DonateNow',
                          textStyle: TextStyles.font18White,
                          onPressed: () {},
                        ),
                        verticalSpace(10),
                        AppTextButton(
                          buttonText: 'Cancel',
                          textStyle: const TextStyle(
                            color: ColorManager.mainOrange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
