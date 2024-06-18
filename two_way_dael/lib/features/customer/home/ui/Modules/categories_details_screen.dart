import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/food_details.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_food_item.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../data/models/category_details_model.dart';
import '../../logic/cubit/customer_cubit.dart';
import '../../logic/cubit/customer_states.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final Data? category;
  CategoriesDetailsScreen({super.key, required this.category});

  final bottomSheetKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        // if (state is CustomerAddToCartState) {
        //   showToast(
        //     message:
        //         'Added Successfully\nGo to your cart to complete check out',
        //     state: TostStates.SUCCESS,
        //   );
        // }

        if (state is GetProductDetailsSuccessState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => FoodDetails(
              product:
                  CustomerCubit.get(context).productDetails!.data!.product!,
            ),
          ));
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);

        return Scaffold(
          floatingActionButton: cubit.cartProducts.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: 20.0.h),
                  child: SizedBox(
                    width: 125.w,
                    child: FloatingActionButton(
                      backgroundColor: ColorManager.mainOrange,
                      child: Text(
                        'Go To Cart ${cubit.cartProducts.length}',
                        style: TextStyles.font17WhiteBold,
                      ),
                      onPressed: () {
                        context.pushNamed(Routes.cartScreen);
                      },
                    ),
                  ),
                )
              : Container(),
          key: bottomSheetKey,
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                scrolledUnderElevation: 0.0,
                leading: customIconButton(
                  toolTip: 'back',
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icons.arrow_back,
                  color: ColorManager.mainOrange,
                ),
                centerTitle: true,
                expandedHeight: 70,
                toolbarHeight: 60,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    // 'ProductDetails',
                    '${category?.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorManager.mainOrange,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Products Count: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17.0),
                                      ),
                                      if (category?.productsCount != null)
                                        Text(
                                          '${category?.productsCount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.mainOrange,
                                                  fontSize: 19.0),
                                        ),
                                    ],
                                  ),
                                  // verticalSpace(0),
                                  if (cubit.categoryDetails != null &&
                                      cubit.categoryDetails!.data != null &&
                                      cubit.categoryDetails!.data!.products !=
                                          null)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0.h),
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio:
                                            1 / 1.4, 
                                        children: List.generate(
                                          cubit.categoryDetails!.data!.products!
                                              .length,
                                          (index) => InkWell(
                                            onTap: () {
                                              if (cubit.categoryDetails !=
                                                      null &&
                                                  cubit.categoryDetails!.data !=
                                                      null &&
                                                  cubit.categoryDetails!.data!
                                                          .products !=
                                                      null &&
                                                  index <
                                                      cubit
                                                          .categoryDetails!
                                                          .data!
                                                          .products!
                                                          .length) {
                                                cubit.getProductDetails(
                                                    id: cubit
                                                        .categoryDetails!
                                                        .data!
                                                        .products![index]
                                                        .id!);
                                              }
                                            },
                                            child: buildItem(
                                                context,
                                                cubit.categoryDetails!.data!
                                                    .products![index]),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio:
                                            1 / 1.4, //width / height
                                        children: List.generate(
                                            4,
                                            (index) => Container(
                                                  width: 50,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                )),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
