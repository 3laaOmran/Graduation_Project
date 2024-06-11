import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/const.dart';
import 'package:two_way_dael/features/seller/home/ui/widgets/notification_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController benfitsController = TextEditingController();

  File? imagePick1;
  File? imagePick2;
  File? imagePick3;
  final ImagePicker picker = ImagePicker();

  // ignore: unused_field
  uploadImagefromCameraorGallary(ImageSource source, int numberImage) async {
    var pickedimage = await picker.pickImage(source: source);
    if (pickedimage != null) {
      setState(() {
        if (numberImage == 1) {
          imagePick1 = File(pickedimage.path);
        } else if (numberImage == 2) {
          imagePick2 = File(pickedimage.path);
        } else {
          imagePick3 = File(pickedimage.path);
        }
      });
    }
  }

  // dynamic openBottomSheet(BuildContext context, int numberImage) {
  //   return showAdaptiveActionSheet(
  //     context: context,
  //     androidBorderRadius: 30,
  //     actions: <BottomSheetAction>[
  //       BottomSheetAction(
  //           title: const Text('Camera'),
  //           onPressed: (context) {
  //             uploadImagefromCameraorGallary(ImageSource.camera, numberImage);
  //           }),
  //       BottomSheetAction(
  //           title: const Text('Gallery'),
  //           onPressed: (context) {
  //             uploadImagefromCameraorGallary(ImageSource.gallery, numberImage);
  //           }),
  //     ],
  //     cancelAction: CancelAction(
  //         title: const Text(
  //             'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
  //   );
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productDescriptionController.dispose();
    discountController.dispose();
    productNameController.dispose();
    benfitsController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.mainOrange,
      appBar: AppBar(
        backgroundColor: ColorManager.mainOrange,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        actions: [
         
          notificationButton(2),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              child: resuableText(
                  text: "Add new Product ",
                  color: Colors.white,
                  fontsize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
              width: 450.w,
              height: 700.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    resuableText(
                        text: "Add Product Images",
                        fontsize: 20.sp,
                        fontWeight: FontWeight.bold),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              width: 180.w,
                              height: 170.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: imagePick1 == null
                                      ? DecorationImage(
                                          image: AssetImage(
                                              images["background_img_picker"]!),
                                          fit: BoxFit.none)
                                      : DecorationImage(
                                          image: FileImage(imagePick1!)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0)),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0)),
                                  border: Border.all(
                                      color: ColorManager.mainOrange,
                                      width: 1.0)),
                              child: CircleAvatar(
                                radius: 17.0,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    // openBottomSheet(context, 1);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 20.0,
                                    color: ColorManager.mainOrange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: 130.w,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: imagePick2 == null
                                          ? DecorationImage(
                                              image: AssetImage(images[
                                                  "background_img_picker"]!),
                                              fit: BoxFit.none)
                                          : DecorationImage(
                                              image: FileImage(imagePick2!)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0)),
                                      border: Border.all(
                                          color: ColorManager.mainOrange,
                                          width: 1.0)),
                                  child: CircleAvatar(
                                    radius: 17.0,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        // openBottomSheet(context, 2);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 20.0,
                                        color: ColorManager.mainOrange,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: 130.w,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: imagePick3 == null
                                          ? DecorationImage(
                                              image: AssetImage(images[
                                                  "background_img_picker"]!),
                                              fit: BoxFit.none)
                                          : DecorationImage(
                                              image: FileImage(imagePick3!)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0)),
                                      border: Border.all(
                                          color: ColorManager.mainOrange,
                                          width: 1.0)),
                                  child: CircleAvatar(
                                    radius: 17.0,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        // openBottomSheet(context, 3);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 20.0,
                                        color: ColorManager.mainOrange,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        resuableText(
                            text: "Product Name",
                            fontsize: 14.sp,
                            fontWeight: FontWeight.bold),
                        resuableText(
                            text: "Discount",
                            fontsize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextFormFieldForAddProduct(
                          typefield: "name",
                          controller: productNameController,
                          hinttext: "Chicken Soup",
                          width: 220.w,
                          height: 50.h,
                        ),
                        CustomTextFormFieldForAddProduct(
                          typefield: "discount",
                          controller: discountController,
                          hinttext: "\t\t\t\t\t\t\t%",
                          width: 95.w,
                          height: 50.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    resuableText(
                        text: "Product Description",
                        fontsize: 14.sp,
                        fontWeight: FontWeight.bold),
                    CustomTextFormFieldForAddProduct(
                      typefield: "description",
                      controller: productDescriptionController,
                      hinttext:
                          "lormlormlormlormlormlormlormlormlormlormlormlormlormlormlormlormlorm",
                      width: 300.w,
                      height: 150.h,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    resuableText(
                        text: "Category",
                        fontsize: 14.sp,
                        fontWeight: FontWeight.bold),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          customChooseTypeOfProduct("Food"),
                          customChooseTypeOfProduct("Drink"),
                          customChooseTypeOfProduct("Soup"),
                          customChooseTypeOfProduct("Pizza"),
                          customChooseTypeOfProduct("Burgar"),
                          customChooseTypeOfProduct("Burgar"),
                          customChooseTypeOfProduct("Burgar"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              CustomTextFormFieldForAddProduct(
                                  controller: priceController,
                                  hinttext: "58",
                                  width: 130.w,
                                  height: 50.h,
                                  typefield: "price")
                            ],
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your benefits",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              CustomTextFormFieldForAddProduct(
                                  controller: benfitsController,
                                  hinttext: "58",
                                  width: 130.w,
                                  height: 40.h,
                                  typefield: "benfits")
                            ],
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.cancel)),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: ColorManager.mainOrange),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200.h,
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFormFieldForAddProduct extends StatefulWidget {
  final TextEditingController? controller;
  final String? hinttext;
  final String? typefield;
  final double? width;
  final double? height;

  const CustomTextFormFieldForAddProduct(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.width,
      required this.height,
      required this.typefield});

  @override
  State<CustomTextFormFieldForAddProduct> createState() =>
      _CustomTextFormFieldForAddProductState();
}

class _CustomTextFormFieldForAddProductState
    extends State<CustomTextFormFieldForAddProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        maxLines: widget.typefield == "description" ? 3 : 1,
        controller: widget.controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: widget.hinttext,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 10), // Adjust vertical padding

            suffix: widget.typefield == "price" || widget.typefield == "benfits"
                ? const Text(
                    "|egp",
                    style: TextStyle(color: Colors.black),
                  )
                : null),
      ),
    );
  }
}

Widget customChooseTypeOfProduct(String? text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.w),
    child: SizedBox(
      width: 100.w,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            side: const BorderSide(color: ColorManager.mainOrange)),
        child: Text(text!),
      ),
    ),
  );
}
