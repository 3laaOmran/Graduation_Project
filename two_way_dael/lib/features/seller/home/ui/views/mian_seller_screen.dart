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
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/build_seller_product_item.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/seller_home_skelton_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SellerCubit.get(context);
        var model = cubit.sellerDataModel;

        if (model == null || model.data == null) {
          return const SellerHomeSkeltonLoading();
        }

        var name = model.data!.name;
        var balance = model.data!.balance;
        var image = model.data!.image;
        var rate = double.tryParse('${model.data!.rate}') ?? 0.0;

        return Column(
          children: [
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.changeBottomNav(cubit.currentIndex + 1);
                      if (cubit.currentIndex != 1) {
                        cubit.currentIndex = 2;
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CircleAvatar(
                        radius: 30.0.w,
                        backgroundColor: Colors.white,
                        backgroundImage: image !=
                                    'http://2waydeal.online/uploads/default.png' ||
                                image == null
                            ? NetworkImage(image!)
                            : null,
                        child: image !=
                                'http://2waydeal.online/uploads/default.png'
                            ? null
                            : const Image(
                                image: AssetImage(
                                    'assets/images/two_way_deal_icon.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      // child: CircleAvatar(
                      //   radius: 30.0,
                      //   backgroundImage: image !=
                      //           'http://2waydeal.online/uploads/default.png'
                      //       ? NetworkImage(
                      //           image!,
                      //         )
                      //       : const AssetImage(
                      //               'assets/images/default_profile.png')
                      //           as ImageProvider,
                      //   backgroundColor: Colors.white,
                      // ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.changeBottomNav(cubit.currentIndex + 1);
                        if (cubit.currentIndex != 1) {
                          cubit.currentIndex = 2;
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: 180.w,
                            child: Text(
                              name ?? 'Welcome',
                              style: TextStyles.font17BlackBold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: rate,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: ColorManager.mainOrange,
                                ),
                              ),
                              horizontalSpace(5),
                              Text(
                                '$rate Stars',
                                style: TextStyles.font13GreyBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          customIconButton(
                              onPressed: () {
                                context.pushNamed(Routes.sellerNewOrdersScreen);
                              },
                              icon: Icons.fastfood,
                              toolTip: 'New Orders',
                              size: 30.0),
                          Container(
                            padding: EdgeInsetsDirectional.only(
                              top: 7.0.h,
                              end: 7.0.w,
                            ),
                            child: const CircleAvatar(
                              radius: 4.5,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 3.5,
                                backgroundColor: ColorManager.mainOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          customIconButton(
                            onPressed: () {
                              context
                                  .pushNamed(Routes.sellerNotificationsScreen);
                            },
                            icon: Icons.notifications,
                            toolTip: 'Notifications',
                            size: 30.0,
                          ),
                          if (cubit.sellerNotificationsModel?.data
                                      ?.isNotEmpty ==
                                  true &&
                              cubit.sellerNotificationsModel!.data!.first
                                      .isRead ==
                                  false)
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
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: height * 0.8,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              ColorManager.mainOrange,
                              Colors.orangeAccent,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        verticalSpace(22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  resuableText(
                                    text: "Your Balance",
                                    fontsize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  verticalSpace(7),
                                  resuableText(
                                    text: balance!,
                                    fontsize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  resuableText(
                                    text: "Withdrawal",
                                    fontsize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  AppTextButton(
                                    backgroundColor: Colors.white,
                                    buttonHeight: 20,
                                    buttonText: 'Withdraw',
                                    textStyle: TextStyles.font17MainOrangeBold
                                        .copyWith(fontSize: 15),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Center(
                                              child: Text(
                                            'Withdraw Request',
                                            style: TextStyles
                                                .font28MainOrangeBold
                                                .copyWith(
                                              fontSize: 20,
                                            ),
                                          )),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Choose your withdrawal method',
                                                style:
                                                    TextStyles.font14BlackBold,
                                              ),
                                              verticalSpace(15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: Text('VISA'),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            ColorManager.gray,
                                                        width: 1.5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  horizontalSpace(15),
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: Text('Cash'),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            ColorManager.gray,
                                                        width: 1.5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              verticalSpace(15),
                                              Text(
                                                'Enter amount',
                                                style:
                                                    TextStyles.font14BlackBold,
                                              ),
                                              verticalSpace(15),
                                              const CustomTextFormField(
                                                isObsecureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText: 'Enter amount',
                                              ),
                                              verticalSpace(20),
                                              Text(
                                                'Enter Number',
                                                style:
                                                    TextStyles.font14BlackBold,
                                              ),
                                              verticalSpace(15),
                                              const CustomTextFormField(
                                                isObsecureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText: 'Enter  Number',
                                              ),
                                              verticalSpace(20),
                                            ],
                                          ),
                                          actions: [
                                            AppTextButton(
                                              buttonText: 'Close',
                                              textStyle: TextStyles.font12White,
                                              onPressed: () {
                                                context.pop();
                                              },
                                              buttonWidth: 80,
                                              buttonHeight: 15,
                                            ),
                                            AppTextButton(
                                              buttonText: 'Send',
                                              textStyle: TextStyles.font12White,
                                              onPressed: () {
                                                context.pop();
                                                showToast(
                                                    message:
                                                        'Request Sent Successfully',
                                                    state: TostStates.SUCCESS);
                                              },
                                              buttonWidth: 80,
                                              buttonHeight: 15,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(15),
                        AppTextButton(
                          backgroundColor: Colors.white,
                          buttonText: 'Publish New Product',
                          textStyle: TextStyles.font17MainOrangeBold,
                          onPressed: () {
                            context.pushNamed(Routes.sellerAddNewProduct);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: height * 0.22,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: width,
                      height: height,
                      decoration: const BoxDecoration(
                          color: Color(0XFFff751a),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(80))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Container(
                            child: resuableText(
                                text: "Best Seller",
                                fontsize: 25.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          verticalSpace(10),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  bottom: 20.h,
                                  top: 10.h),
                              child: Builder(
                                builder: (context) {
                                  if (cubit.sellerProducts == null ||
                                      cubit.sellerProducts!.data == null) {
                                    return Column(
                                      children: [
                                        verticalSpace(50),
                                        Text(
                                          'No Sold Products yet',
                                          style: TextStyles.font20Whitebold,
                                        ),
                                        verticalSpace(20),
                                        AppTextButton(
                                          backgroundColor: Colors.white,
                                          buttonText: 'Publish New Product',
                                          textStyle:
                                              TextStyles.font17MainOrangeBold,
                                          onPressed: () {
                                            context.pushNamed(
                                                Routes.sellerAddNewProduct);
                                          },
                                        ),
                                      ],
                                    );
                                  }

                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1 / 1.4,
                                    ),
                                    itemCount:
                                        cubit.sellerProducts!.data!.length,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {},
                                      child: BuildSellerProductItem(
                                          product: cubit
                                              .sellerProducts!.data![index]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
