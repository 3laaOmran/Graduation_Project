import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts({super.key});

  @override
  State<SellerProducts> createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  var selectedPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyles.font20blackbold,
          ),
          verticalSpace(10),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // BuildCategoryItem(text: 'All'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  // BuildCategoryItem(text: 'Food'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  // BuildCategoryItem(text: 'Drink'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  // BuildCategoryItem(text: 'Soup'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  // BuildCategoryItem(text: 'Pizza'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  // BuildCategoryItem(text: 'Burger'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  // BuildCategoryItem(text: 'Soda'),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                ],
              ),
            ),
          ),
          verticalSpace(20),
          Text(
            'All Products $selectedPageNumber',
            style: TextStyles.font20blackbold,
          ),
          // NumberPagination(
          //   groupSpacing: 5,
          //   threshold: 15,
          //   buttonRadius: 20,
          //   pageInit: selectedPageNumber,
          //   colorPrimary: ColorManager.mainOrange,
          //   colorSub: ColorManager.notificationColor,
          //   onPageChanged: (index) {
          //     setState(() {
          //       selectedPageNumber = index;
          //     });
          //   },
          //   pageTotal: 5,
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   child: GridView.count(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 5,
          //     mainAxisSpacing: 1,
          //     childAspectRatio: 1 / 1.35, //width / height

          //     children: List.generate(
          //       10,
          //       (index) => buildItem(context),
          //     ),
          //   ),
          // ),
          NumberPagination(
            groupSpacing: 5,
            threshold: 15,
            buttonRadius: 20,
            pageInit: selectedPageNumber,
            colorPrimary: ColorManager.mainOrange,
            colorSub: ColorManager.notificationColor,
            onPageChanged: (index) {
              setState(() {
                selectedPageNumber = index;
              });
            },
            pageTotal: 3,
          ),
        ],
      ),
    );
  }
}
