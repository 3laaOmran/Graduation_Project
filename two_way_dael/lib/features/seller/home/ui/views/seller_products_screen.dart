import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/home_skelton_loading.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';
import 'package:two_way_dael/features/seller/home/ui/views/edit_product.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/build_seller_product_item.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  @override
  void initState() {
    super.initState();
    SellerCubit.get(context).getSellerProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        if (state is GetSellerProductDetailsSuccessState) {
          if (state.sellerProductDetails.status == 200) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    EditProduct(product: state.sellerProductDetails),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              toolbarHeight: 80,
              title: resuableText(
                text: "Your Products",
                fontsize: 25.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              backgroundColor: ColorManager.mainOrange,
              centerTitle: true,
            ),
            // SliverAppBar(
            //   scrolledUnderElevation: 0.0,
            //   pinned: true,
            //   toolbarHeight: 80,
            //   automaticallyImplyLeading: false,
            //   title: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         const BuildCategoryItem(text: 'All'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Food'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Drink'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Soup'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Pizza'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Burger'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Soda'),
            //         horizontalSpace(10),
            //         const BuildCategoryItem(text: 'Others'),
            //         horizontalSpace(10),
            //       ],
            //     ),
            //   ),
            // ),
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: 100.h, right: 20.w, left: 20.w, top: 20.h),
              sliver: state is! GetSellerProductsLoadingState
                  ? cubit.sellerProducts != null &&
                          cubit.sellerProducts!.data != null &&
                          cubit.sellerProducts!.data!.isNotEmpty
                      ? SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.4,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => InkWell(
                              onTap: () {
                                cubit.getSellerProductDetails(
                                    id: cubit.sellerProducts!.data![index].id!);
                              },
                              child: BuildSellerProductItem(
                                  product: cubit.sellerProducts!.data![index]),
                            ),
                            childCount: cubit.sellerProducts!.data!.length,
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              verticalSpace(50),
                              const Image(
                                  image: AssetImage(
                                      'assets/images/noproducts.png')),
                              AppTextButton(
                                buttonText: 'Publish New Product',
                                textStyle: TextStyles.font17WhiteBold,
                                onPressed: () {
                                  context.pushNamed(Routes.sellerAddNewProduct);
                                },
                              ),
                            ],
                          ),
                        ))
                  : SliverToBoxAdapter(
                      child: buildShimmerWidget(
                        component: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1 / 1.4,
                          children: List.generate(
                              8,
                              (index) => Container(
                                    width: 50.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                  )),
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget buildFilterBox({
    required var color,
    required String name,
    required void Function() ontap,
  }) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: 90.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorManager.mixedColor, width: 1.1),
        ),
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
