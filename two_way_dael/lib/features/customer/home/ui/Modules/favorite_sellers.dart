import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/data/models/favorites_model.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_favorite_seller_item.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/seller_products.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/show_rate_us_alert_dialog.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/sliver_appbar_delegate.dart';

class FavoriteSellers extends StatelessWidget {
  const FavoriteSellers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var favModel = cubit.favoritesModel;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            backgroundColor: ColorManager.mainOrange,
            title: Text(
              'Favorite Sellers',
              style: TextStyles.font20Whitebold,
            ),
          ),
          body: favModel!.data!.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/add_favorites.png'),
                    verticalSpace(30),
                    Text(
                      'You don\'t have a \nfavorite sellers yet..',
                      style: TextStyles.font18Grey800bold,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(50),
                    AppTextButton(
                      buttonText: 'Add Some',
                      buttonWidth: 200,
                      textStyle: TextStyles.font17WhiteBold,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ))
              : CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 1,
                              childAspectRatio: 1 / 1.5, //width / height

                              children: List.generate(
                                  favModel.data!.length,
                                  (index) => InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FavSellerDetailsItem(
                                                          favoritesData:
                                                              favModel.data![
                                                                  index])));
                                        },
                                        child: BuildFavoriteSellerItem(
                                          favItem: favModel.data![index],
                                        ),
                                      )),
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

class FavSellerDetailsItem extends StatefulWidget {
  const FavSellerDetailsItem({super.key, required this.favoritesData});
  final FavoritesData favoritesData;

  @override
  State<FavSellerDetailsItem> createState() => _FavSellerDetailsItemState();
}

class _FavSellerDetailsItemState extends State<FavSellerDetailsItem> {
  late Widget currentWidget;
  bool isAboutSelected = true;

  @override
  void initState() {
    super.initState();
    currentWidget = buildFavoriteSellers();
  }

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
                    currentWidget = buildFavoriteSellers();
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
                      backgroundColor: widget.favoritesData.isFavourite!
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
                              if (widget.favoritesData.isFavourite!) {
                                widget.favoritesData.isFavourite = false;
                                cubit.removeFromFavorites(
                                    id: widget.favoritesData.sellerId!);
                                cubit.getFavoriteSellers();
                              } else {
                                widget.favoritesData.isFavourite = true;
                                cubit.addToFavorites(
                                    id: widget.favoritesData.sellerId!);
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
                    '\t ${widget.favoritesData.name!}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ColorManager.mainOrange,
                    ),
                  ),
                  background: Hero(
                    tag: 1,
                    child: Image.network(
                      widget.favoritesData.image!,
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
                                  currentWidget = buildFavoriteSellers();
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
                                cubit.getSellerProducts(
                                    id: widget.favoritesData.sellerId!);
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

  Widget buildFavoriteSellers() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(20),
          Text(
            'Customer Reviews',
            style: TextStyles.font20blackbold,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    RatingBarIndicator(
                      rating: double.tryParse(widget.favoritesData.rate!) ?? 0.0,
                      itemCount: 5,
                      itemSize: 30.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: ColorManager.mainOrange,
                      ),
                    ),
                    verticalSpace(5),
                    Text(
                      '${widget.favoritesData.rateWithReviews}',
                      style: TextStyles.font13GreyBold,
                    ),
                  ],
                ),
                const Spacer(),
                AppTextButton(
                  buttonWidth: 110,
                  buttonHeight: 30,
                  verticalPadding: 0,
                  textStyle: TextStyles.font12White,
                  buttonText: 'Send Review',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ShowAlertDialog(
                          storeId: widget.favoritesData.id!,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          verticalSpace(20),
          Text(
            'About',
            style: TextStyles.font20blackbold,
          ),
          verticalSpace(20),
          richText(
            text1: 'Address: ',
            text2: ' ${widget.favoritesData.address}',
          ),
          verticalSpace(20),
          richText(
            text1: 'Contacts: ',
            text2: ' ${widget.favoritesData.phone}',
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}

Widget richText({
  required String text1,
  required String text2,
}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(text: text1, style: TextStyles.font17BlackBold),
        TextSpan(text: text2, style: TextStyles.font17BlackBold),
      ],
    ),
  );
}
