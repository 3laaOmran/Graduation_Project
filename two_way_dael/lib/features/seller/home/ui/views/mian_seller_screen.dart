import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: const CircleAvatar(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      resuableText(
                          text: "Seller Name",
                          fontsize: 24.sp,
                          fontWeight: FontWeight.bold),
                      resuableText(
                          text: "Rate",
                          color: Colors.grey[600],
                          fontsize: 12.5.sp),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      customIconButton(
                        onPressed: () {
                          context.pushNamed(Routes.sellerNotificationsScreen);
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
            ),
            Stack(
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
                      SizedBox(
                        height: 22.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          resuableText(
                              text: "Your sales",
                              fontsize: 15.sp,
                              color: Colors.white),
                          resuableText(
                              text: "Add balance",
                              fontsize: 15.sp,
                              color: Colors.white),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          resuableText(
                              text: "148,911",
                              fontsize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          Container(
                            alignment: Alignment.center,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                            child: InkWell(
                              onTap: () {},
                              child: resuableText(
                                  text: "Withdraw",
                                  fontsize: 12.sp,
                                  color: ColorManager.mainOrange),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: height * 0.15,
                  child: Container(
                    alignment: Alignment.topLeft,
                    width: width,
                    // height: height * 0.7,
                    decoration: const BoxDecoration(
                        color: Color(0XFFff751a), //Color(0XFFff751a)
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.05),
                        Container(
                          margin: EdgeInsets.only(left: width * 0.05),
                          alignment: Alignment.topLeft,
                          child: resuableText(
                              text: "Best Seller",
                              fontsize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20.w, left: 20.w),
                          height: height * 0.22,
                          child: ListView.builder(
                              itemCount: slider.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20.w, right: 20.w),
                                        width: width * 0.35,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              slider[index],
                                              fit: BoxFit.fitWidth,
                                            ),
                                            resuableText(
                                                text: "Chicken Soup",
                                                fontsize: 15.sp),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                resuableText(
                                                    text: "58 eg",
                                                    fontsize: 10.sp),
                                                InkWell(
                                                  onTap: () {},
                                                  child:
                                                      const Icon(Icons.cancel),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons.add_circle,
                                                    color:
                                                        ColorManager.mainOrange,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Divider(
                          endIndent: width * 0.07,
                          indent: width * 0.06,
                          color: Colors.white,
                          thickness: 2,
                        ),
                        SizedBox(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 24.w),
                                  alignment: Alignment.topLeft,
                                  child: resuableText(
                                      text: "Offers",
                                      fontsize: 24.sp,
                                      color: Colors.white),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 20.w, left: 20.w),
                                  height: height * 0.23,
                                  child: ListView.builder(
                                      itemCount: slider.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 20.w, right: 20.w),
                                                width: width * 0.35,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      slider[index],
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                    resuableText(
                                                        text: "Chicken Soup",
                                                        fontsize: 15.sp),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        resuableText(
                                                            text: "58 eg",
                                                            fontsize: 10.sp),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: const Icon(
                                                              Icons.cancel),
                                                        ),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: const Icon(
                                                            Icons.add_circle,
                                                            color: ColorManager
                                                                .mainOrange,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: height * 0.5,
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
