import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/const.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  var boxColor1 = mixedColor;
  var boxColor2 = Colors.white;
  var boxColor3 = Colors.white;
  var boxColor4 = Colors.white;
  var boxColor5 = Colors.white;
  String selectedType = "Food";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(images["backgroundimage"]!))),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                alignment: Alignment.topLeft,
                child: resuableText(
                    text: "Your Products",
                    fontsize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            SizedBox(
              height: 20.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildFilterBox(
                      color: boxColor1,
                      name: "Food",
                      ontap: () {
                        setState(() {
                          if (boxColor1 == Colors.white) {
                            boxColor1 = mixedColor;
                            boxColor2 = Colors.white;
                            boxColor3 = Colors.white;
                            boxColor4 = Colors.white;
                            boxColor5 = Colors.white;
                          }
                        });
                      }),
                  buildFilterBox(
                      color: boxColor2,
                      name: "Drink",
                      ontap: () {
                        setState(() {
                          if (boxColor2 == Colors.white) {
                            boxColor2 = mixedColor;
                            boxColor1 = Colors.white;
                            boxColor3 = Colors.white;
                            boxColor4 = Colors.white;
                            boxColor5 = Colors.white;

                            selectedType = "Drink";
                          }
                        });
                      }),
                  buildFilterBox(
                      color: boxColor3,
                      name: "Soup",
                      ontap: () {
                        setState(() {
                          if (boxColor3 == Colors.white) {
                            boxColor3 = mixedColor;
                            boxColor2 = Colors.white;
                            boxColor1 = Colors.white;
                            boxColor4 = Colors.white;
                            boxColor5 = Colors.white;

                            selectedType = "Soup";
                          }
                        });
                      }),
                  buildFilterBox(
                      color: boxColor4,
                      name: "Pizza",
                      ontap: () {
                        setState(() {
                          if (boxColor4 == Colors.white) {
                            boxColor4 = mixedColor;
                            boxColor2 = Colors.white;
                            boxColor3 = Colors.white;
                            boxColor1 = Colors.white;
                            boxColor5 = Colors.white;
                            selectedType = "Pizza";
                          }
                        });
                      }),
                  buildFilterBox(
                      color: boxColor5,
                      name: "Burger",
                      ontap: () {
                        setState(() {
                          if (boxColor5 == Colors.white) {
                            boxColor5 = mixedColor;
                            boxColor2 = Colors.white;
                            boxColor3 = Colors.white;
                            boxColor4 = Colors.white;
                            boxColor1 = Colors.white;

                            selectedType = "Burger";
                          }
                        });
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 20.h),
              height: height,
              child: GridView.builder(
                itemCount: slider.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Card(
                            margin: EdgeInsets.only(left: 15.w, right: 15.w),
                            color: Colors.grey[100],
                            elevation: 5,
                            // width: 200.w,
                            // decoration: BoxDecoration(
                            //     color: Colors.grey[200],
                            //     borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Image.asset(
                                  slider[index],
                                  // fit: BoxFit.fitWidth,
                                ),
                                resuableText(
                                    text: "Chicken Soup",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.bold
                                    // color: Colors.white,
                                    ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    resuableText(
                                      text: "58 eg",
                                      fontsize: 14.sp,
                                      // color: Colors.white,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.cancel,
                                        color: mixedColor,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.add_circle,
                                        color: mixedColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // childAspectRatio: 0.95,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2),
              ),
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }

  Widget buildFilterBox(
      {required var color,
      required String name,
      required void Function() ontap}) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: 90.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: mixedColor, width: 1.1)),
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                // color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
