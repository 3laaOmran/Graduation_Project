import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/categories_details_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/food_details.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/best_sale_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_category_item.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_food_item.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/home_skelton_loading.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/top_deals.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetBestSalesSuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BestSaleScreen(
                bestsaleModel: state.bestSalesModel!,
              ),
            ),
          );
        }
        if (state is GetTopDealsSuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TopDeals(
                bestsaleModel2: state.bestSalesModel2!,
              ),
            ),
          );
        }
        if (state is GetProductDetailsSuccessState) {
          var productDetails =
              CustomerCubit.get(context).productDetails?.data?.product;
          if (productDetails != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FoodDetails(product: productDetails),
            ));
          }
        }
        if (state is GetCategoryDetailsSuccessState) {
          var categoryDetails =
              CustomerCubit.get(context).categoryDetails?.data;
          if (categoryDetails != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    CategoriesDetailsScreen(category: categoryDetails),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var model = cubit.userDataModel;

        if (model == null || model.data == null) {
          return const HomeSkeltonLoading();
        }

        var name = model.data!.name;
        var image = model.data!.profilePicture;
        return Scaffold(
          floatingActionButton: cubit.cartProducts.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: 100.h),
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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                scrolledUnderElevation: 0.0,
                backgroundColor: Colors.white,
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false,
                pinned: true,
                title: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.changeBottomNav(cubit.currentIndex + 1);
                        if (cubit.currentIndex != 1) {
                          cubit.currentIndex = 0;
                        }
                      },
                      child: CircleAvatar(
                        radius: 25.0.w,
                        backgroundColor: Colors.white,
                        backgroundImage: image != null &&
                                image !=
                                    'http://2waydeal.online/uploads/default.png'
                            ? NetworkImage(image)
                            : null,
                        child: image == null ||
                                image ==
                                    'http://2waydeal.online/uploads/default.png'
                            ? const Image(
                                image: AssetImage(
                                    'assets/images/two_way_deal_icon.png'),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    horizontalSpace(10),
                    InkWell(
                      onTap: () {
                        cubit.changeBottomNav(cubit.currentIndex + 1);
                        if (cubit.currentIndex != 1) {
                          cubit.currentIndex = 0;
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$name',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                          ),
                          verticalSpace(5),
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
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(Routes.cartScreen);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/cart.png'),
                            width: 35,
                          ),
                          if (cubit.cartProducts.isNotEmpty)
                            CircleAvatar(
                              radius: 8.5.w,
                              backgroundColor: ColorManager.mainOrange,
                              child: Text(
                                '${cubit.cartProducts.length}',
                                style: TextStyles.font12White
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment:
                        cubit.notificationsModel?.data?.isNotEmpty == true &&
                                cubit.notificationsModel!.data!.first.isRead ==
                                    false
                            ? AlignmentDirectional.topEnd
                            : AlignmentDirectional.center,
                    children: [
                      customIconButton(
                        onPressed: () {
                          context.pushNamed(Routes.notificationsScreen);
                        },
                        icon: Icons.notifications,
                        toolTip: 'Notifications',
                        size: 30.0,
                      ),
                      if (cubit.notificationsModel?.data?.isNotEmpty == true &&
                          cubit.notificationsModel!.data!.first.isRead == false)
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
                              child: CustomTextFormField(
                                readOnly: true,
                                onTap: () {
                                  context.pushNamed(Routes.searchScreen);
                                  CustomerCubit.get(context)
                                      .getSearchData(categryId: 200);
                                },
                                hintText: 'Search...',
                                isObsecureText: false,
                                sufixIcon: Icons.search,
                                suffixIconSize: 25,
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
                            const SizedBox(height: 5.0),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CarouselSlider(
                                items: [
                                  InkWell(
                                    onTap: () {
                                      cubit.getBestSale(
                                          id: cubit.deals?.data?.bestsale?.id ??
                                              0);
                                    },
                                    child: Image(
                                      image: NetworkImage(
                                        cubit.deals?.data?.bestsale?.image ??
                                            'https://img.freepik.com/free-psd/japanese-food-restaurant-horizontal-banner-template_23-2149447411.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.getTopDeals(
                                          id: cubit.deals?.data?.topdeals?.id ??
                                              0);
                                    },
                                    child: Image(
                                      image: NetworkImage(
                                        cubit.deals?.data?.topdeals?.image ??
                                            'https://img.freepik.com/free-psd/japanese-food-restaurant-horizontal-banner-template_23-2149447411.jpg?size=626&ext=jpg&ga=GA1.1.1916073333.1698184272&semt=ais',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                                options: CarouselOptions(
                                  height: 200.0,
                                  initialPage: 0,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: false,
                                  autoPlay: true,
                                  autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1),
                                  reverse: false,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: 25,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final categoriesModel =
                                          CustomerCubit.get(context)
                                              .categoriesModel;
                                      if (categoriesModel != null &&
                                          categoriesModel.data != null &&
                                          categoriesModel.data!.length >
                                              index) {
                                        return InkWell(
                                          onTap: () {
                                            var categoryId =
                                                categoriesModel.data?[index].id;
                                            if (categoryId != null) {
                                              CustomerCubit.get(context)
                                                  .getCategoryDetails(
                                                      id: categoryId);
                                            }
                                          },
                                          child: buildCatItem(context,
                                              categoriesModel.data![index]),
                                        );
                                      }
                                      return Container();
                                    },
                                    separatorBuilder: (context, index) =>
                                        horizontalSpace(10),
                                    itemCount: CustomerCubit.get(context)
                                            .categoriesModel
                                            ?.data
                                            ?.length ??
                                        0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25.0),
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
                                cubit.productsModel!.data!.products != null &&
                                state is! CustomerGetProductsLoadingState)
                              Padding(
                                padding: EdgeInsets.only(bottom: 100.0.h),
                                child: Column(
                                  children: [
                                    GridView.count(
                                      padding: EdgeInsets.only(bottom: 20.0.h),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1 / 1.4,
                                      children: List.generate(
                                        cubit.productsModel!.data!.products!
                                            .length,
                                        (index) {
                                          var product = cubit.productsModel!
                                              .data!.products![index];
                                          return InkWell(
                                            onTap: () {
                                              var productId = product.id;
                                              if (productId != null) {
                                                cubit.getProductDetails(
                                                    id: productId);
                                              }
                                            },
                                            child: buildItem(context, product),
                                          );
                                        },
                                      ),
                                    ),
                                    if (cubit.productsModel!.data!
                                            .productsCount! >
                                        20)
                                      NumberPagination(
                                        groupSpacing: 5,
                                        threshold: 3,
                                        buttonRadius: 50,
                                        pageInit: cubit.selectedPageNumber,
                                        colorPrimary: ColorManager.mainOrange,
                                        colorSub:
                                            ColorManager.notificationColor,
                                        onPageChanged: (index) {
                                          cubit.getProducts(page: index);
                                          setState(() {
                                            cubit.selectedPageNumber = index;
                                          });
                                        },
                                        pageTotal: cubit.productsModel!.data!
                                            .pagination!.lastPage!,
                                      ),
                                  ],
                                ),
                              )
                            else if (cubit.productsModel?.data?.products !=
                                null)
                              Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor: Colors.grey[300]!,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1 / 1.4,
                                  children: List.generate(
                                    cubit.productsModel!.data!.products!.length,
                                    (index) => Container(
                                      width: 50.w,
                                      height: 90.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
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
          ),
        );
      },
    );
  }
}
