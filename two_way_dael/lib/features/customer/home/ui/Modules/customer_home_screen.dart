import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/features/customer/home/data/models/categoties_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/categories_details_screen.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/food_details.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_food_item.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/home_skelton_loading.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    CustomerCubit.get(context).loadCart();
  }

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
        if (state is GetCategoryDetailsSuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoriesDetailsScreen(
                category: CustomerCubit.get(context).categoryDetails?.data,
              ),
            ),
          );
        }
        // },
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
                          // cubit.clearCart();
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
                          backgroundImage: image! ==
                                  'http://2waydeal.online/uploads/default.png'
                              ? Image.asset(
                                  'assets/images/two_way_deal_icon.png',
                                  fit: BoxFit.cover,
                                ).image
                              : Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                ).image,
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
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.pushNamed(Routes.cartScreen);
                        },
                        child: Stack(
                          alignment: cubit.cartProducts.isNotEmpty
                              ? Alignment.center
                              : Alignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/cart.png'),
                              width: 35,
                            ),
                            cubit.cartProducts.isNotEmpty
                                ? CircleAvatar(
                                    radius: 8.5.w,
                                    backgroundColor: ColorManager.mainOrange,
                                    child: Text(
                                      '${cubit.cartProducts.length}',
                                      style: TextStyles.font12White.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(),
                          ],
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
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0.0)),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                                CustomerCubit.get(context)
                                                    .getCategoryDetails(
                                                        id: CustomerCubit.get(
                                                                context)
                                                            .categoriesModel
                                                            ?.data?[index]
                                                            .id);
                                              },
                                              child: buildCatItem(
                                                  context,
                                                  categoriesModel
                                                      .data![index]));
                                        }
                                        return null;
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
                                  cubit.productsModel!.data!.products != null)
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1 / 1.4, //width / height
                                  children: List.generate(
                                    cubit.productsModel!.data!.products!.length,
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
                                    childAspectRatio: 1 / 1.4, //width / height

                                    children: List.generate(
                                        4,
                                        (index) => Container(
                                              width: 50,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
            ));
      },
    );
  }

  Widget buildCatItem(BuildContext context, CategoryData data) => Container(
        width: 53.0,
        height: 23.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
            color: ColorManager.mainOrange,
            width: 1.3,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: Text(
            '${data.name}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                  color: ColorManager.mainOrange,
                ),
          ),
        ),
      );
}
