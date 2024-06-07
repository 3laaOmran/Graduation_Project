import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/home/ui/Modules/food_details.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_ctegory_item.dart';
import 'package:two_way_dael/features/home/ui/widgets/build_food_item.dart';
import 'package:two_way_dael/features/home/ui/widgets/home_skelton_loading.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetProductDetailsSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FoodDetails(
                    product: CustomerCubit.get(context)
                        .productDetails!
                        .data!
                        .product!,
                  )));
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        return Scaffold(
          body: state is! GetUserDataLoadingState
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      scrolledUnderElevation: 0.0,
                      backgroundColor: Colors.white,
                      toolbarHeight: 60.h,
                      leadingWidth: 70,
                      pinned: true,
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          child: Image(
                            image: AssetImage(
                              'assets/images/two_way_deal_icon.png',
                            ),
                            width: 45,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Two Way Deal',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                          ),
                          Text(
                            'Shopping Time?',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0),
                          ),
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container());
                            },
                            child: const Image(
                              image: AssetImage('assets/images/moved_cart.gif'),
                              width: 35,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            customIconButton(
                              onPressed: () {
                                context.pushNamed(Routes.notificationsScreen);
                              },
                              icon: Icons.notifications,
                              toolTip: 'Notifications',
                              size: 30.0,
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                top: 11.0,
                                end: 14.0,
                              ),
                              child: const CircleAvatar(
                                radius: 3.5,
                                backgroundColor: ColorManager.mainOrange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 20.0,
                              end: 20.0,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalSpace(15),
                                  Material(
                                    elevation: 6,
                                    shadowColor: Colors.grey,
                                    borderRadius: BorderRadius.circular(25),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.pushNamed(Routes.searchScreen);
                                        CustomerCubit.get(context)
                                            .getSearchData(categryId: 200);
                                      },
                                      child: const CustomTextFormField(
                                        enabled: false,
                                        hintText: 'Search...',
                                        isObsecureText: false,
                                        sufixIcon: Icons.search,
                                        suffixIconSize: 25,
                                      ),
                                    ),
                                  ),
                                  verticalSpace(25),
                                  Text(
                                    'News & Offers',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21.0),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0.0)),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: CarouselSlider(
                                      items: const [
                                        Image(
                                          image: NetworkImage(
                                            'https://img.freepik.com/free-psd/japanese-food-restaurant-horizontal-banner-template_23-2149447411.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais',
                                          ),
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              'https://img.freepik.com/free-psd/delicious-food-facebook-template_23-2150056445.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              'https://img.freepik.com/free-vector/flat-food-landing-page-template_23-2149046596.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              'https://img.freepik.com/free-vector/online-grocery-store-banner-design_23-2150085726.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais'),
                                        ),
                                      ],
                                      options: CarouselOptions(
                                        height: 200.0,
                                        initialPage: 0,
                                        viewportFraction: 1.0,
                                        enableInfiniteScroll: true,
                                        enlargeCenterPage: false,
                                        autoPlay: true,
                                        autoPlayCurve:
                                            Curves.fastEaseInToSlowEaseOut,
                                        autoPlayInterval:
                                            const Duration(seconds: 5),
                                        autoPlayAnimationDuration:
                                            const Duration(seconds: 1),
                                        reverse: false,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Categories',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21.0),
                                  ),
                                  verticalSpace(5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        height: 25,
                                        child: Row(
                                          children: [
                                            const BuildCategoryItem(
                                                text: 'All'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Food'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Drink'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Soup'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Pizza'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Burger'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Soda'),
                                            horizontalSpace(10),
                                            const BuildCategoryItem(
                                                text: 'Others'),
                                            horizontalSpace(10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Text(
                                    'Meals you might like',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21.0),
                                  ),
                                  verticalSpace(15),
                                  if (cubit.productsModel != null &&
                                      cubit.productsModel!.data != null &&
                                      cubit.productsModel!.data!.products !=
                                          null)
                                    GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio:
                                          1 / 1.4, //width / height
                                      children: List.generate(
                                        cubit.productsModel!.data!.products!
                                            .length,
                                        (index) => InkWell(
                                          onTap: () {
                                            cubit.getProductDetails(
                                                id: cubit.productsModel!.data!
                                                    .products![index].id!);
                                          },
                                          child: buildItem(
                                              context,
                                              cubit.productsModel!.data!
                                                  .products![index]),
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
                    )
                  ],
                )
              : const HomeSkeltonLoading(),
        );
      },
    );
  }
}
