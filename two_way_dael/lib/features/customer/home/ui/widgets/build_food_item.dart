import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

import '../../../../../core/theming/styles.dart';
import '../../data/models/products_model.dart';

Widget buildItem(context, Products model) =>
    BlocBuilder<CustomerCubit, CustomerStates>(
      builder: (context, state) {
        final cubit = CustomerCubit.get(context);
        final isInCart = cubit.isInCart(model);
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
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: model.images!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(model.images![1]),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                                image: AssetImage(
                                    'assets/images/no_product_image.png'),
                                fit: BoxFit.cover),
                      ),
                    ),
                    model.discount != null
                        ? Positioned(
                            bottom: 20.h,
                            child: Container(
                              width: 70.w,
                              height: 20.h,
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              child: Text(
                                '${model.discount!} off',
                                style: TextStyles.font12White,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              verticalSpace(10),
              Text(
                model.name!,
                style: TextStyles.font17BlackBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(5),
              Row(
                children: [
                  Text(
                    '${model.netPrice!} egp',
                    style: TextStyles.font13GreyBold,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      cubit.toggleCart(model);
                    },
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: !isInCart
                          ? ColorManager.gray
                          : ColorManager.mainOrange,
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
