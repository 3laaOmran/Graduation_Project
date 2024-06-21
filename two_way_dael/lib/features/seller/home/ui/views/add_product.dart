import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/build_category_item.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? imagePick1;
  File? imagePick2;
  File? imagePick3;
  final ImagePicker picker = ImagePicker();
  int? categoryId;
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
      bottomSheetColor: Colors.white,
      context: context,
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: (context) {
              context.pop();
              uploadImagefromCameraorGallary(ImageSource.camera, numberImage);
            }),
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: (context) {
              context.pop();
              uploadImagefromCameraorGallary(ImageSource.gallery, numberImage);
            }),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        if (state is SellerAddProductSuccessState) {
          context.pop();
          SellerCubit.get(context).clearControllers();
          showToast(
              message: 'Product Added Successfully', state: TostStates.SUCCESS);
        } else if (state is SellerAddProductErrorState) {
          showToast(message: state.error, state: TostStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = SellerCubit.get(context);

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
                    padding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AbsorbPointer(
                      absorbing:
                          state is SellerAddProductLoadingState ? true : false,
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
                          Form(
                            key: cubit.addproductFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          resuableText(
                                              text: "Add Name",
                                              fontsize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          CustomTextFormField(
                                            controller:
                                                cubit.addproductNameController,
                                            isObsecureText: false,
                                            hintText: 'ProductName',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter product name';
                                              }
                                              return null;
                                            },
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
                                  controller:
                                      cubit.addproductDescriptionController,
                                  isObsecureText: false,
                                  hintText: 'Product Description',
                                  maxLines: 4,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter product description';
                                    }
                                    return null;
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                verticalSpace(15),
                                resuableText(
                                    text: "Choose Category",
                                    fontsize: 14.sp,
                                    fontWeight: FontWeight.bold),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      height: 25,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final categoriesModel =
                                              cubit.categoriesModel;
                                          if (categoriesModel != null &&
                                              categoriesModel.data != null &&
                                              categoriesModel.data!.length >
                                                  index) {
                                            final category =
                                                categoriesModel.data![index];
                                            final isSelected =
                                                cubit.selectedCategoryId ==
                                                    category.id;
                                            return InkWell(
                                              onTap: () {
                                                cubit.selectCategory(
                                                    category.id!);
                                                categoryId = category.id!;
                                              },
                                              child: buildCatItem(
                                                  context, category,
                                                  isSelected: isSelected),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                        separatorBuilder: (context, index) =>
                                            horizontalSpace(10),
                                        itemCount: cubit.categoriesModel?.data
                                                ?.length ??
                                            0,
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpace(15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          resuableText(
                                              text: "Price",
                                              fontsize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          CustomTextFormField(
                                            controller:
                                                cubit.addpriceController,
                                            keyboardType: TextInputType.number,
                                            isObsecureText: false,
                                            hintText: 'Price',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter price';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    horizontalSpace(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          resuableText(
                                              text: "Discount",
                                              fontsize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          CustomTextFormField(
                                            controller:
                                                cubit.adddiscountController,
                                            keyboardType: TextInputType.number,
                                            isObsecureText: false,
                                            hintText: 'Disc',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter discount';
                                              }
                                              return null;
                                            },
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          resuableText(
                                              text: "Expiry Date",
                                              fontsize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter expiry date';
                                              }
                                              return null;
                                            },
                                            onTap: () {
                                              debugPrint('Expiry date Tapped');
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2030-05-01'),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    cubit
                                                        .addexpirydateController
                                                        .text = DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(value);
                                                  });
                                                }
                                              });
                                            },
                                            readOnly: true,
                                            controller:
                                                cubit.addexpirydateController,
                                            keyboardType:
                                                TextInputType.datetime,
                                            isObsecureText: false,
                                            hintText: 'Expiry Date',
                                          ),
                                        ],
                                      ),
                                    ),
                                    horizontalSpace(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          resuableText(
                                              text: "Quantity",
                                              fontsize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please enter quantity';
                                              }
                                              return null;
                                            },
                                            controller:
                                                cubit.addquantityController,
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
                                resuableText(
                                    text: "Available For",
                                    fontsize: 14.sp,
                                    fontWeight: FontWeight.bold),
                                CustomTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter available for';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    debugPrint('Available for date Tapped');
                                    showDatePicker(
                                      barrierColor: ColorManager.mainOrange,
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2030-05-01'),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          cubit.addavailableForController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(value);
                                        });
                                      }
                                    });
                                  },
                                  readOnly: true,
                                  controller: cubit.addavailableForController,
                                  keyboardType: TextInputType.datetime,
                                  isObsecureText: false,
                                  hintText: 'Available For',
                                ),
                              ],
                            ),
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
                                    cubit.clearControllers();
                                  },
                                ),
                              ),
                              horizontalSpace(10),
                              Expanded(
                                child: AppTextButton(
                                  textStyle: TextStyles.font17WhiteBold,
                                  buttonText:
                                      state is SellerAddProductLoadingState
                                          ? 'Publishing...'
                                          : 'Publish',
                                  onPressed: () {
                                    if (cubit.addproductFormKey.currentState!
                                        .validate()) {
                                      if (imagePick1 == null ||
                                          imagePick2 == null ||
                                          imagePick3 == null) {
                                        showToast(
                                          message:
                                              'Please Add All Product Images',
                                          state: TostStates.ERROR,
                                        );
                                        return;
                                      }
                                      if (categoryId == null) {
                                        showToast(
                                            message: 'Please Choose Category',
                                            state: TostStates.ERROR);
                                      }
                                      try {
                                        double price = double.parse(
                                            cubit.addpriceController.text);
                                        double discount = double.parse(
                                            cubit.adddiscountController.text);
                                        double quantity = double.parse(
                                            cubit.addquantityController.text);
                                        DateTime expiryDate =
                                            DateFormat('yyyy-MM-dd').parse(cubit
                                                .addexpirydateController.text);
                                        DateTime availableFor =
                                            DateFormat('yyyy-MM-dd').parse(cubit
                                                .addavailableForController
                                                .text);

                                        cubit.addSellerProduct(
                                          images: [
                                            if (imagePick1 != null) imagePick1!,
                                            if (imagePick2 != null) imagePick2!,
                                            if (imagePick3 != null) imagePick3!,
                                          ],
                                          categoryId: categoryId!,
                                          price: price,
                                          discount: discount,
                                          name: cubit
                                              .addproductNameController.text,
                                          description: cubit
                                              .addproductDescriptionController
                                              .text,
                                          expiryDate: expiryDate,
                                          availableFor: availableFor,
                                          quantity: quantity,
                                        );
                                      } catch (e) {
                                        debugPrint('Error in input data: $e');
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
