import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:animations/animations.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/seller_about.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/seller_products.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/sliver_appbar_delegate.dart';

class SellerDetailsScreen extends StatefulWidget {
  const SellerDetailsScreen({super.key});

  @override
  State<SellerDetailsScreen> createState() => _SellerDetailsScreenState();
}

Widget currentWidget = const SellerAbout();
bool isAboutSelected = true;

class _SellerDetailsScreenState extends State<SellerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is CustomerGetSellerProductsSuccessState) {
          setState(() {
            isAboutSelected = false;
            currentWidget = SellerProducts(
              productsList: state.productsModel2.data!.products!,
            );
          });
        }
        if (state is AddToFavoritesSuccessState) {
          showToast(message: 'Added To Favorites', state: TostStates.SUCCESS);
          CustomerCubit.get(context).getFavoriteSellers();
        }
        if (state is RemoveFromFavoritesSuccessState) {
          showToast(message: 'Removed From Favorites', state: TostStates.SUCCESS);
          CustomerCubit.get(context).getFavoriteSellers();
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var store = cubit.productDetails!.data!.product!.store;
        return Scaffold(
          floatingActionButton: cubit.cartProducts.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
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
                leading: customIconButton(
                  toolTip: 'back',
                  onPressed: () {
                    Navigator.of(context).pop();
                    currentWidget = const SellerAbout();
                    isAboutSelected = true;
                  },
                  icon: Icons.arrow_back,
                  color: ColorManager.mainOrange,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: store!.isInFav!
                          ? ColorManager.mainOrange
                          : ColorManager.gray,
                      child: Center(
                        child: customIconButton(
                          padding: const EdgeInsets.only(
                            left: 2.0,
                            right: 2.0,
                            top: 3.0,
                            bottom: 2.0,
                          ),
                          onPressed: () {
                            setState(() {
                              if (store.isInFav!) {
                                store.isInFav = false;
                                cubit.removeFromFavorites(id: store.id!);
                                cubit.getFavoriteSellers();
                              } else {
                                store.isInFav = true;
                                cubit.addToFavorites(id: store.id!);
                                
                              }
                            });
                          },
                          icon: Icons.favorite,
                          color: Colors.white,
                          size: 25.0,
                          toolTip: 'Favorite',
                        ),
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
                expandedHeight: 350,
                toolbarHeight: 60,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    '\t ${store.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorManager.mainOrange,
                    ),
                  ),
                  background: Hero(
                    tag: 1,
                    child: Image.network(
                      store.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_profile.png',
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  minHeight: 50.0,
                  maxHeight: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: ColorManager.gray,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAboutSelected = true;
                                  currentWidget = const SellerAbout();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isAboutSelected
                                      ? ColorManager.mainOrange
                                      : Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'About',
                                    style: isAboutSelected
                                        ? TextStyles.font17WhiteBold
                                        : TextStyles.font17BlackBold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1.3,
                            color: ColorManager.gray,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                cubit.getSellerProducts(id: store.id!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isAboutSelected
                                      ? Colors.white
                                      : ColorManager.mainOrange,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Products',
                                    style: isAboutSelected
                                        ? TextStyles.font17BlackBold
                                        : TextStyles.font17WhiteBold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 900),
                        transitionBuilder: (Widget child,
                            Animation<double> primaryAnimation,
                            Animation<double> secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            child: child,
                          );
                        },
                        child: currentWidget,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
