import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_saerch_filter.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_search_item.dart';

import '../widgets/search_drop_down_menu.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String categoryDropDownValue = '1';
  bool sortByPriceUsed = true;
  bool sortByDateUsed = false;
  bool sortWithAscUsed = true;
  bool sortWithDescUsed = false;
  var searchTextController = TextEditingController();
  var minPriceController = TextEditingController();
  var maxPriceController = TextEditingController();
  String? sortby;
  String? sortwith;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var model = cubit.searchModel;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80.h,
            leading: customIconButton(
              toolTip: 'back',
              onPressed: () {
                context.pop();
              },
              icon: Icons.arrow_back,
              color: Colors.white,
            ),
            backgroundColor: ColorManager.mainOrange,
            title: TextField(
              autofocus: true,
              controller: searchTextController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: TextStyles.font20Whitebold,
              ),
              style: TextStyles.font20Whitebold,
              onChanged: (value) {
                if (sortByPriceUsed) {
                  sortby = 'price';
                } else if (sortByDateUsed) {
                  sortby = 'created_at';
                }
                if (sortWithAscUsed) {
                  sortwith = 'asc';
                } else if (sortWithDescUsed) {
                  sortwith = 'desc';
                }
                cubit.getSearchData(
                  name: searchTextController.text,
                  categryId: int.parse(categoryDropDownValue),
                  minPrice: minPriceController.text,
                  maxPrice: maxPriceController.text,
                  sortBy: sortwith,
                  sortWith: sortwith,
                );
              },
            ),
            actions: [
              customIconButton(
                  onPressed: () {
                    searchTextController.clear();
                    cubit.getSearchData();
                  },
                  icon: Icons.clear,
                  color: Colors.white,
                  toolTip: 'Clear')
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: searchDropDownMenue(
                          title: 'Search For',
                          value: categoryDropDownValue,
                          items: cubit.categoriesList,
                          onChange: (String? newValue) {
                            setState(() {
                              categoryDropDownValue = newValue!;
                              debugPrint(newValue);
                            });
                          },
                        ),
                      ),
                      horizontalSpace(5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Min Price',
                              style: TextStyles.font14BlackBold,
                            ),
                            CustomTextFormField(
                              controller: minPriceController,
                              borderRadius: BorderRadius.circular(10),
                              keyboardType: TextInputType.number,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              isObsecureText: false,
                              hintText: 'Min',
                              hintStyle: TextStyles.font13GreyBold,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Max Price',
                              style: TextStyles.font14BlackBold,
                            ),
                            CustomTextFormField(
                              controller: maxPriceController,
                              borderRadius: BorderRadius.circular(10),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 6.h),
                              keyboardType: TextInputType.number,
                              isObsecureText: false,
                              hintText: 'Max',
                              hintStyle: TextStyles.font13GreyBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 40.h,
                    thickness: 1.5.h,
                    endIndent: 40.w,
                    indent: 40.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sort by',
                            style: TextStyles.font14BlackBold,
                          ),
                          Row(
                            children: [
                              buildSearchFilterItem(
                                text: 'Price',
                                ontap: () {
                                  setState(() {
                                    sortByPriceUsed = !sortByPriceUsed;
                                    sortByDateUsed = false;
                                    sortWithDescUsed == false
                                        ? sortWithAscUsed = true
                                        : sortWithAscUsed = false;
                                  });
                                },
                                bgColor: sortByPriceUsed
                                    ? ColorManager.notificationColor
                                    : Colors.white,
                                borderColor: sortByPriceUsed
                                    ? ColorManager.mainOrange
                                    : ColorManager.gray,
                                textColor: sortByPriceUsed
                                    ? ColorManager.mainOrange
                                    : Colors.black,
                              ),
                              horizontalSpace(10),
                              buildSearchFilterItem(
                                text: 'Date Modified',
                                ontap: () {
                                  setState(() {
                                    sortByDateUsed = !sortByDateUsed;
                                    sortByPriceUsed = false;
                                    sortWithDescUsed == false
                                        ? sortWithAscUsed = true
                                        : sortWithAscUsed = false;
                                  });
                                },
                                bgColor: sortByDateUsed
                                    ? ColorManager.notificationColor
                                    : Colors.white,
                                borderColor: sortByDateUsed
                                    ? ColorManager.mainOrange
                                    : ColorManager.gray,
                                textColor: sortByDateUsed
                                    ? ColorManager.mainOrange
                                    : Colors.black,
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sort With',
                            style: TextStyles.font14BlackBold,
                          ),
                          Row(
                            children: [
                              buildSearchFilterItem(
                                text: 'Asc',
                                ontap: () {
                                  setState(() {
                                    sortWithAscUsed = !sortWithAscUsed;
                                    sortWithDescUsed = false;
                                  });
                                },
                                bgColor: sortWithAscUsed
                                    ? ColorManager.notificationColor
                                    : Colors.white,
                                borderColor: sortWithAscUsed
                                    ? ColorManager.mainOrange
                                    : ColorManager.gray,
                                textColor: sortWithAscUsed
                                    ? ColorManager.mainOrange
                                    : Colors.black,
                              ),
                              horizontalSpace(10),
                              buildSearchFilterItem(
                                text: 'Desc',
                                ontap: () {
                                  setState(() {
                                    sortWithDescUsed = !sortWithDescUsed;
                                    sortWithAscUsed = false;
                                  });
                                },
                                bgColor: sortWithDescUsed
                                    ? ColorManager.notificationColor
                                    : Colors.white,
                                borderColor: sortWithDescUsed
                                    ? ColorManager.mainOrange
                                    : ColorManager.gray,
                                textColor: sortWithDescUsed
                                    ? ColorManager.mainOrange
                                    : Colors.black,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  verticalSpace(20),
                  state is GetSearchDataLoadingState
                      ? const Center(
                          child: LinearProgressIndicator(
                            color: ColorManager.mainOrange,
                          ),
                        )
                      : Container(),
                  state is GetSearchDataLoadingState ||
                          model!.data!.productsCount == 0 ||
                          searchTextController.text.isEmpty
                      ? Column(
                          children: [
                            verticalSpace(80),
                            const Image(
                              image: AssetImage('assets/images/searching.png'),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Reasults : ${model.data!.productsCount}',
                              style: TextStyles.font17BlackBold,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1 / 1.4, //width / height
                              children: List.generate(
                                  model.data!.products!.length,
                                  (index) => buildSearchItem(
                                      model.data!.products![index])),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
