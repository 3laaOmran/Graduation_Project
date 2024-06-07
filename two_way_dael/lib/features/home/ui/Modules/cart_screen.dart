import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';

import '../../../../core/theming/colors.dart';
import '../../logic/cubit/customer_cubit.dart';
import '../../logic/cubit/customer_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CustomerCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Cart',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 23.0,
                  color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: InkWell(
                  onTap: () {
                    cubit.clearCart(cubit.cartProducts);
                  },
                  child: const Image(
                    image: AssetImage('assets/images/delete.png'),
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
          body: cubit.cartProducts.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/empty_cart.png'),
                    Text(
                      'Empty Cart\nGo add some products',
                      style: TextStyles.font17BlackBold.copyWith(height: 2),
                      textAlign: TextAlign.center,
                    )
                  ],
                )
              : ListView.separated(
                  itemBuilder: (context, index) =>
                      itemBottomSheet(context, index),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 2.0,
                  ),
                  itemCount: cubit.cartProducts.length,
                ),
        );
      },
    );
  }

  Widget itemBottomSheet(BuildContext context, int index) {
    final cubit = CustomerCubit.get(context);
    final product = cubit.cartProducts[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 14.0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.white,
                elevation: 10.0,
                child: Container(
                  width: 300,
                  height: 85.0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: SizedBox(
                            height: 68.0,
                            width: 65.0,
                            child: CachedNetworkImage(
                              imageUrl: product.images!.isNotEmpty
                                  ? product.images![0]
                                  : '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 13.0,
                                      ),
                                ),
                                Expanded(
                                  child: Row(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.baseline,
                                    // textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cubit.minus();
                                        },
                                        child: Container(
                                          width: 30.0.w,
                                          height: 30.0.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1.5,
                                              color: ColorManager.gray,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        '${cubit.itemQuantity}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                      ),
                                      horizontalSpace(5),
                                      InkWell(
                                        onTap: () {
                                          cubit.plus();
                                          debugPrint('${cubit.itemQuantity}');
                                        },
                                        child: Container(
                                          width: 30.0.w,
                                          height: 30.0.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1.5,
                                              color: ColorManager.gray,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${product.price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[800],
                                              fontSize: 13.0,
                                            ),
                                      ),
                                      Text(
                                        'egp',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                              fontSize: 10.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                cubit.removeFromCart(product);
              },
              child: const Icon(
                Icons.delete_outlined,
                size: 30.0,
                color: ColorManager.mainOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
