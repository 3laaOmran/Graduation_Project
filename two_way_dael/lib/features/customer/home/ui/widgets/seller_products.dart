import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/food_details.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_food_item.dart';

import '../../data/models/products_model.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts({super.key, required this.productsList});
  final List<Products> productsList;

  @override
  State<SellerProducts> createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  var selectedPageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetProductDetailsSuccessState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetails(
                      product: CustomerCubit.get(context)
                          .productDetails!
                          .data!
                          .product!)));
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var productsModel2 = cubit.productsModel2;
        var productsList = productsModel2?.data?.products;
        var productsCount = productsModel2?.data?.productsCount;
        var lastPage = productsModel2?.data?.pagination?.lastPage;
        var store = cubit.productDetails?.data?.product?.store;

        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Products',
                style: TextStyles.font20blackbold,
              ),
              if (productsList != null &&
                  state is! CustomerGetSellerProductsPaginationLoadingState)
                Column(
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.only(bottom: 20.0.h),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1 / 1.4,
                      ),
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (productsList[index].id != null) {
                              cubit.getProductDetails(
                                  id: productsList[index].id!);
                            }
                          },
                          child: buildItem(context, productsList[index]),
                        );
                      },
                    ),
                    if (productsCount != null &&
                        productsCount > 20 &&
                        lastPage != null)
                      NumberPagination(
                        groupSpacing: 5,
                        threshold: 3,
                        buttonRadius: 50,
                        pageInit: selectedPageNumber,
                        colorPrimary: ColorManager.mainOrange,
                        colorSub: ColorManager.notificationColor,
                        onPageChanged: (index) {
                          cubit.sellerProductsPagination(
                            id: store!.id ??
                                cubit.favoritesModel!.data![index].sellerId!,
                            page: index,
                          );
                          setState(() {
                            selectedPageNumber = index;
                          });
                        },
                        pageTotal: lastPage,
                      ),
                  ],
                )
              else if (state is CustomerGetSellerProductsPaginationLoadingState)
                Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[300]!,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / 1.4,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => Container(
                      width: 50.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
