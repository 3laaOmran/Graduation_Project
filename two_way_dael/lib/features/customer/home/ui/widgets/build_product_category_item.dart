import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/features/customer/home/data/models/category_details_model.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../logic/cubit/customer_cubit.dart';
import '../../logic/cubit/customer_states.dart';

Widget buildProductCategory(context, CategoryProducts? model) =>
    BlocBuilder<CustomerCubit, CustomerStates>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
                offset: Offset(8, 15),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage('${model?.images?[1]}'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              verticalSpace(10),
              Text(
                '${model?.name}',
                style: TextStyles.font17BlackBold,
              ),
              verticalSpace(5),
              Row(
                children: [
                  Text(
                    '${model?.price} egp',
                    style: TextStyles.font13GreyBold,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ColorManager.gray,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 4.w,
                          left: 4.w,
                        ),
                        child: Image(
                          image:
                              const AssetImage('assets/images/white_cart.png'),
                          width: 30.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );