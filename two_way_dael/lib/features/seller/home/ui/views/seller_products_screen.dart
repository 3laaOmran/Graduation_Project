import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_ctegory_item.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/build_seller_product_item.dart';

class SellerProductsScreen extends StatelessWidget {
  const SellerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        SliverAppBar(
          scrolledUnderElevation: 0.0,
          pinned: true,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const BuildCategoryItem(text: 'All'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Food'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Drink'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Soup'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Pizza'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Burger'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Soda'),
                horizontalSpace(10),
                const BuildCategoryItem(text: 'Others'),
                horizontalSpace(10),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.4,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => InkWell(
                onTap: () {},
                child: buildSellerProductItem(),
              ),
              childCount: 20,
            ),
          ),
        ),
      ],
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
