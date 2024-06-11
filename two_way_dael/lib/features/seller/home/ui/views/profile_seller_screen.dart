import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/const.dart';

class ProfileSellerScreen extends StatefulWidget {
  const ProfileSellerScreen({super.key});

  @override
  State<ProfileSellerScreen> createState() => _ProfileSellerScreenState();
}

class _ProfileSellerScreenState extends State<ProfileSellerScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "profileScreenKey");

  final ImagePicker picker = ImagePicker();
  File? image;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dateController.dispose();
    totalAmountController.dispose();
  }

  uploadImagefromCameraorGallary(ImageSource source) async {
    var pickedimage = await picker.pickImage(source: source);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    }
  }

  // dynamic openBottomSheet(BuildContext context) {
  //   return showAdaptiveActionSheet(
  //     context: context,
  //     androidBorderRadius: 30,
  //     actions: <BottomSheetAction>[
  //       BottomSheetAction(
  //           title: const Text('Camera'),
  //           onPressed: (context) {
  //             uploadImagefromCameraorGallary(ImageSource.camera);
  //           }),
  //       BottomSheetAction(
  //           title: const Text('Gallery'),
  //           onPressed: (context) {
  //             uploadImagefromCameraorGallary(ImageSource.gallery);
  //           }),
  //     ],
  //     cancelAction: CancelAction(
  //         title: const Text(
  //             'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: ClipOval(
                            child: CircleAvatar(
                              radius: width * 0.2,
                              backgroundColor: Color.alphaBlend(
                                  ColorManager.mainOrange, Colors.orangeAccent),
                              backgroundImage: image == null
                                  ? null
                                  : FileImage(
                                      image!,
                                    ),
                              child: image == null
                                  ? Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.white,
                                      size: width * .2,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 120,
                        bottom: 20,
                        child: ClipOval(
                          child: GestureDetector(
                            onTap: () {
                              // openBottomSheet(context);
                            },
                            child: Container(
                              color: Colors.white,
                              width: 35.w,
                              height: 40.h,
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: mixedColor,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  resuableText(
                      text: "Restaurant",
                      fontsize: 24.sp,
                      fontWeight: FontWeight.bold),
                  RatingBarIndicator(
                      rating: 2.5,
                      itemCount: 5,
                      itemSize: 25.0,
                      itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: mixedColor,
                          ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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
                          color: ColorManager.mainOrange),
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      Container(
                        alignment: Alignment.center,
                        width: 100.w,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                            color: ColorManager.mainOrange,
                            borderRadius: BorderRadius.circular(40)),
                        child: InkWell(
                          onTap: () {},
                          child: resuableText(
                              text: "Withdraw",
                              fontsize: 12.sp,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              color: ColorManager.mainOrange,
              indent: 18.w,
              endIndent: 18.w,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  resuableText(text: "Phone", fontsize: 20.sp),
                  // CustomTextFormField(
                  //     hintText: "1274055875",
                  //     controller: phoneController,
                  //     issecurse: false,
                  //     icon: Icons.phone,
                  //     enable: true,
                  //     typefield: "phone"),
                  // resuableText(text: "Email", fontsize: 20.sp),
                  // CustomTextFormField(
                  //     fillcolor: ColorManager.mainOrange.withOpacity(0.3),
                  //     hintText: "Omar@gmail.com",
                  //     controller: emailController,
                  //     issecurse: false,
                  //     icon: Icons.email,
                  //     enable: false,
                  //     typefield: "email"),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  resuableText(text: "Certificates", fontsize: 20.sp),
                  /**
                   * TODO:implement Certificate when connect with back-end
                   */

                  SizedBox(
                    height: height * 0.02,
                  ),
                  resuableText(text: "Address", fontsize: 20.sp),
                  // CustomTextFormField(
                  //     hintText: "5 St Alexandria",
                  //     controller: addressController,
                  //     issecurse: false,
                  //     icon: Icons.location_on_rounded,
                  //     enable: false,
                  //     fillcolor: ColorManager.mainOrange.withOpacity(0.3),
                  //     typefield: "address"),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomTextFormField(
                  //         hintText: "29/8",
                  //         controller: dateController,
                  //         issecurse: false,
                  //         icon: Icons.date_range_outlined,
                  //         enable: false,
                  //         fillcolor: ColorManager.mainOrange.withOpacity(0.3),
                  //         typefield: "data"),
                  //     CustomTextFormField(
                  //         hintText: "21000",
                  //         controller: totalAmountController,
                  //         issecurse: false,
                  //         icon: Icons.attach_money_outlined,
                  //         enable: false,
                  //         fillcolor: ColorManager.mainOrange.withOpacity(0.3),
                  //         typefield: "money"),
                  //   ],
                  // ),
                  // CustomTextFormField(
                  //     hintText: "Alexandria",
                  //     controller: passwordController,
                  //     issecurse: false,
                  //     icon: Icons.location_city_sharp,
                  //     enable: false,
                  //     fillcolor: ColorManager.mainOrange.withOpacity(0.3),
                  //     typefield: "city"),
                  SizedBox(
                    height: height * 0.2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
