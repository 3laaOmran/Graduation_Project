import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/data/models/product_details_model.dart';
import 'package:two_way_dael/features/customer/home/data/models/products_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

class FoodDetails extends StatefulWidget {
  final Product product;
  const FoodDetails({super.key, required this.product});

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  final bottomSheetKey = GlobalKey<ScaffoldState>();
  bool _hasNavigated = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is GetProductDetailsSuccessState && !_hasNavigated) {
          final newProduct =
              CustomerCubit.get(context).productDetails?.data?.product;
          if (newProduct != null) {
            setState(() {
              _hasNavigated = true;
            });
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => FoodDetails(product: newProduct),
            ))
                .then((_) {
              setState(() {
                _hasNavigated = false;
              });
            });
          }
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        Products? productToAdd;
        final productsList = cubit.productsModel?.data?.products ?? [];
        for (var item in productsList) {
          if (item.id == widget.product.id) {
            productToAdd = item;
            break;
          }
        }
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
                actions: const [
                  ReportMenu(),
                ],
                centerTitle: true,
                expandedHeight: 380.h,
                toolbarHeight: 80.h,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    widget.product.category!.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorManager.mainOrange,
                    ),
                  ),
                  background: Hero(
                      tag: widget.product.id!,
                      child: CarouselSlider(
                        items: [
                          widget.product.images!.isNotEmpty &&
                                  widget.product.images![0] !=
                                      'http://2waydeal.online/uploads/default.png'
                              ? Image.network(
                                  widget.product.images![0],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/no_product_image.png',
                                  fit: BoxFit.cover,
                                ),
                          widget.product.images!.isNotEmpty &&
                                  widget.product.images![1] !=
                                      'http://2waydeal.online/uploads/default.png'
                              ? Image.network(
                                  widget.product.images![1],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/no_product_image.png',
                                  fit: BoxFit.cover,
                                ),
                          widget.product.images!.isNotEmpty &&
                                  widget.product.images![2] !=
                                      'http://2waydeal.online/uploads/default.png'
                              ? Image.network(
                                  widget.product.images![2],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/no_product_image.png',
                                  fit: BoxFit.cover,
                                ),
                        ],
                        options: CarouselOptions(
                          height: 380.0.h,
                          initialPage: 0,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: false,
                          reverse: false,
                          scrollDirection: Axis.horizontal,
                        ),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10),
                      buildProductHeader(context),
                      verticalSpace(10),
                      buildProductDescription(context),
                      verticalSpace(20),
                      AppTextButton(
                        textStyle: TextStyles.font20Whitebold,
                        buttonText: productToAdd != null
                            ? (!cubit.isInCart(productToAdd)
                                ? 'Add to cart'
                                : 'Remove From Cart')
                            : 'Add to cart.',
                        onPressed: productToAdd != null
                            ? () {
                                cubit.toggleCart(productToAdd!);
                              }
                            : () {},
                      ),
                      verticalSpace(20),
                      buildOtherProductsSection(context, cubit),
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

  Widget buildProductHeader(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 170.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name ?? '',
                style: TextStyles.font20blackbold,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget.product.netPrice ?? '',
                    style: TextStyles.font17BlackBold,
                  ),
                  horizontalSpace(5),
                  Text(
                    widget.product.price ?? '',
                    style: TextStyles.font15BlackBold.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2.0,
                    ),
                  ),
                  horizontalSpace(5),
                  Text(
                    'egp',
                    style: TextStyles.font14BlackBold,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.pushNamed(Routes.sellerDeatailsScreen);
          },
          child: Column(
            children: [
              verticalSpace(5),
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                backgroundImage:
                    NetworkImage(widget.product.store!.image ?? ''),
              ),
              SizedBox(
                width: 150.0.w,
                child: Text(
                  widget.product.store?.name ?? '',
                  style: TextStyles.font15BlackBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
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
                    ' ${widget.product.store!.rateWithReviews}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w100,
                          color: Colors.grey[700],
                          fontSize: 11.0,
                        ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildProductDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More Information',
          style: TextStyles.font17BlackBold,
        ),
        verticalSpace(10),
        widget.product.expireDate != null
            ? Text(
                'ExpiryDate: ${widget.product.expireDate}',
                style: TextStyles.font15GrayRegular,
              )
            : Container(),
        Text(
          'Available Quantity: ${widget.product.availableQuantity}',
          style: TextStyles.font15GrayRegular,
        ),
        Text(
          'Available For: ${widget.product.availableFor}',
          style: TextStyles.font15GrayRegular,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpace(10),
        Text(
          'Description',
          style: TextStyles.font17BlackBold,
        ),
        verticalSpace(10),
        Text(
          widget.product.description ?? '',
          style: TextStyles.font15GrayRegular,
        ),
      ],
    );
  }

  Widget buildOtherProductsSection(BuildContext context, CustomerCubit cubit) {
    final similarProducts = cubit.productDetails?.data?.similarProducts ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other customers also order these',
          style: TextStyles.font17BlackBold,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final similarProduct = similarProducts[index];
              return InkWell(
                onTap: () {
                  if (!_hasNavigated) {
                    setState(() {
                      _hasNavigated = true;
                    });
                    cubit.getProductDetails(id: similarProduct.id!);
                  }
                },
                child: buildOtherItems(context, similarProduct),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5.0),
            itemCount: similarProducts.length,
          ),
        ),
      ],
    );
  }

  Widget buildOtherItems(BuildContext context, Products product) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 10.0,
      child: Container(
        width: double.infinity,
        height: 100.0.h,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 6.0.h),
        child: Row(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox(
                height: 90.0.h,
                width: 75.0.w,
                child: product.images!.isNotEmpty
                    ? Image.network(
                        product.images![0],
                        fit: BoxFit.cover,
                      )
                    : const Image(
                        image: AssetImage('assets/images/no_product_image.png'),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 5.0),
                        child: Text(
                          product.name ?? '',
                          style: TextStyles.font17BlackBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${product.netPrice}',
                            style: TextStyles.font15GrayRegular,
                          ),
                          horizontalSpace(5),
                          Text(
                            'EGP',
                            style: TextStyles.font13GreyBold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                CustomerCubit.get(context).toggleCart(product);
              },
              child: CircleAvatar(
                radius: 20.0.w,
                backgroundColor: CustomerCubit.get(context).isInCart(product)
                    ? ColorManager.mainOrange
                    : ColorManager.gray,
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w, left: 4.w),
                  child: Image(
                    image: const AssetImage('assets/images/white_cart.png'),
                    width: 30.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportMenu extends StatelessWidget {
  const ReportMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: ColorManager.mainOrange,
      ),
      tooltip: 'more',
      onSelected: (String result) {
        if (result == 'report') {
          debugPrint('Report selected');
        }
      },
      color: Colors.white,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'report',
          child: Text(
            'Report',
            style: TextStyles.font17BlackBold,
          ),
          onTap: () {
            // context.pushNamed(Routes.contactUsScreen);
            showToast(
                message: 'Reported Successfully', state: TostStates.SUCCESS);
          },
        ),
      ],
    );
  }
}
