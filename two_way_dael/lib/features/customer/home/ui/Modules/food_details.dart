import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/components.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/data/models/product_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

class FoodDetails extends StatelessWidget {
  final Product product;
  FoodDetails({super.key, required this.product});

  final bottomSheetKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is CustomerAddToCartState) {
          showToast(
            message:
                'Added Successfully\nGo to your cart to complete check out',
            state: TostStates.SUCCESS,
          );
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
                    Navigator.of(context).pop();
                  },
                  icon: Icons.arrow_back,
                  color: ColorManager.mainOrange,
                ),
                actions: [
                  customIconButton(
                      onPressed: () {},
                      icon: Icons.more_vert,
                      color: ColorManager.mainOrange,
                      toolTip: 'more'),
                ],
                centerTitle: true,
                expandedHeight: 380,
                toolbarHeight: 60,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    // 'ProductDetails',
                    product.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorManager.mainOrange,
                    ),
                  ),
                  background: Hero(
                    tag: 1,
                    child: Image.network(
                      product.images![1],
                      fit: BoxFit.cover,
                    ),
                    // CarouselSlider(
                    //   items: [
                    //     Image.network(
                    //       product.images![0],
                    //       fit: BoxFit.contain,
                    //     ),
                    //     Image.network(
                    //       product.images![1],
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ],
                    //   options: CarouselOptions(
                    //     // height: 200.0,
                    //     initialPage: 0,
                    //     viewportFraction: 1.0,
                    //     enableInfiniteScroll: true,
                    //     enlargeCenterPage: false,
                    //     autoPlay: true,
                    //     autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                    //     autoPlayInterval: const Duration(seconds: 5),
                    //     autoPlayAnimationDuration: const Duration(seconds: 1),
                    //     reverse: false,
                    //     scrollDirection: Axis.horizontal,
                    //   ),
                    // )
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                product.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27.0),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${product.price!}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 24.0),
                                  ),
                                  Text(
                                    'egp',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.pushNamed(Routes.sellerDeatailsScreen);
                            },
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/images/default_profile.png'),
                                ),
                                Text(
                                  product.store!.name!,
                                  style: TextStyles.font15BlackBold,
                                ),
                                verticalSpace(5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: ColorManager.mainOrange,
                                      size: 19.0,
                                    ),
                                    Text(
                                      '5.0 (23 Reviews)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w100,
                                              color: Colors.grey[700],
                                              fontSize: 11.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      verticalSpace(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyles.font17BlackBold,
                          ),
                          verticalSpace(10),
                          Text(
                            product.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[800],
                                    fontSize: 14.0),
                          ),
                        ],
                      ),
                      verticalSpace(20),
                      cartButton(
                        text: 'Add to cart',
                        function: () {
                          // Find the corresponding Products instance
                          Products? productToAdd;
                          final productsList =
                              cubit.productsModel!.data!.products!;
                          for (var item in productsList) {
                            if (item.id == product.id) {
                              productToAdd = item;
                              break;
                            }
                          }

                          if (productToAdd != null) {
                            cubit.addToCart(productToAdd);
                          } else {
                            showToast(
                              message: 'Product not found in list',
                              state: TostStates.ERROR,
                            );
                          }
                        },
                        context: context,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'other customers also order these',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                            fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            buildOtherItems(context),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5.0,
                        ),
                        itemCount: 10,
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

  //------------------------------------------------------------------------------

  Widget buildOtherItems(context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        elevation: 10.0,
        child: Container(
          width: double.infinity,
          height: 80.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    height: 68.0,
                    width: 65.0,
                    child: Image(
                      image: NetworkImage(
                          'https://img.freepik.com/premium-photo/classic-italian-pasta-penne-alla-arrabiata-with-freshly-cheese-dark-table-top-view-generative-ai_47243-2129.jpg?w=740'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(top: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  'Pasta',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 13.0),
                                ),
                                const Spacer(),
                                Text(
                                  '75 ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                          fontSize: 13.0),
                                ),
                                Text(
                                  'egp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                          fontSize: 7.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: ColorManager.mainOrange,
                                    size: 18.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: ColorManager.mainOrange,
                                    size: 18.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: ColorManager.mainOrange,
                                    size: 18.0,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: ColorManager.mainOrange,
                                    size: 18.0,
                                  ),
                                  const Icon(
                                    Icons.star_half,
                                    color: ColorManager.mainOrange,
                                    size: 18.0,
                                  ),
                                  Text(
                                    '(12)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600],
                                            fontSize: 10.0),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              CircleAvatar(
                                radius: 13.0,
                                backgroundColor: ColorManager.mainOrange,
                                child: IconButton(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 2.0, start: 4.0),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 17.0,
                                    color: Colors.white,
                                  ),
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
      );

  //-----------------------------------------------------------------------------------------
}
