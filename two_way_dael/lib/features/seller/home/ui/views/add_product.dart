import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import '../../../../customer/home/ui/widgets/build_ctegory_item.dart';

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
  TextEditingController expirydateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

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

  dynamic openBottomSheet(BuildContext context, int numberImage) {
    return showAdaptiveActionSheet(
      context: context,
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: (context) {
              uploadImagefromCameraorGallary(ImageSource.camera, numberImage);
            }),
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: (context) {
              uploadImagefromCameraorGallary(ImageSource.gallery, numberImage);
            }),
      ],
      cancelAction: CancelAction(
          title: const Text(
              'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productDescriptionController.dispose();
    discountController.dispose();
    productNameController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.mainOrange,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorManager.mainOrange,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: resuableText(
            text: "Add new Product ",
            color: Colors.white,
            fontsize: 20.sp,
            fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    resuableText(
                        text: "Add Product Images",
                        fontsize: 17.sp,
                        fontWeight: FontWeight.bold),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildPickImage(
                          onPressed: () {
                            openBottomSheet(context, 1);
                          },
                          image: imagePick1 == null
                              ? const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/image_picker_background.png'),
                                )
                              : DecorationImage(
                                  image: FileImage(imagePick1!),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Column(
                          children: [
                            buildPickImage(
                              width: 125.w,
                              height: 95.h,
                              onPressed: () {
                                openBottomSheet(context, 2);
                              },
                              image: imagePick2 == null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image_picker_background.png'),
                                    )
                                  : DecorationImage(
                                      image: FileImage(imagePick2!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            buildPickImage(
                              width: 125.w,
                              height: 95.h,
                              onPressed: () {
                                openBottomSheet(context, 3);
                              },
                              image: imagePick3 == null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/image_picker_background.png'),
                                    )
                                  : DecorationImage(
                                      image: FileImage(imagePick3!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        )
                      ],
                    ),
                    verticalSpace(15),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resuableText(
                                  text: "Add Name",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              CustomTextFormField(
                                controller: productNameController,
                                isObsecureText: false,
                                hintText: 'ProductName',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(15),
                    resuableText(
                        text: "Add Description",
                        fontsize: 14.sp,
                        fontWeight: FontWeight.bold),
                    CustomTextFormField(
                      controller: productDescriptionController,
                      isObsecureText: false,
                      hintText: 'Product Description',
                      maxLines: 4,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    verticalSpace(15),
                    resuableText(
                        text: "Choose Category",
                        fontsize: 14.sp,
                        fontWeight: FontWeight.bold),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: 25,
                          child: Row(
                            children: [
                              const BuildCategoryItem(text: 'All'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Food'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Drink'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Soup'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Pizza'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Burger'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Soda'),
                              horizontalSpace(10),
                              const BuildCategoryItem(text: 'Others'),
                              horizontalSpace(10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resuableText(
                                  text: "Price",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              CustomTextFormField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                isObsecureText: false,
                                hintText: 'Price',
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resuableText(
                                  text: "Discount",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              CustomTextFormField(
                                controller: discountController,
                                keyboardType: TextInputType.number,
                                isObsecureText: false,
                                hintText: 'Disc',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resuableText(
                                  text: "Expiry Date",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              CustomTextFormField(
                                controller: expirydateController,
                                keyboardType: TextInputType.datetime,
                                isObsecureText: false,
                                hintText: 'Expiry Date',
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resuableText(
                                  text: "Quantity",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold),
                              CustomTextFormField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                isObsecureText: false,
                                hintText: 'Quantity',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: AppTextButton(
                            textStyle: TextStyles.font17WhiteBold,
                            buttonText: 'cancel',
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),
                        horizontalSpace(10),
                        Expanded(
                          child: AppTextButton(
                            textStyle: TextStyles.font17WhiteBold,
                            buttonText: 'Publish',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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

Widget buildPickImage({
  required DecorationImage image,
  required void Function() onPressed,
  double? width,
  double? height,
}) {
  return SizedBox(
    width: width ?? 190.w,
    height: height ?? 190.h,
    child: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: width != null ? width - 10 : 180.w,
            height: height != null ? height - 10 : 180.h,
            decoration: BoxDecoration(
                color: Colors.white,
                image: image,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                )),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(color: ColorManager.mainOrange, width: 1.0)),
            child: CircleAvatar(
              radius: 17.0,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.add,
                  size: 20.0,
                  color: ColorManager.mainOrange,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
