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
import 'package:two_way_dael/features/seller/home/data/models/seler_product_details.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class EditProduct extends StatefulWidget {
  final SellerProductDetails product;

  const EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? imagePick1;
  File? imagePick2;
  File? imagePick3;
  final ImagePicker picker = ImagePicker();

  Future<void> uploadImageFromCameraOrGallery(
      ImageSource source, int numberImage) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        final imageFile = File(pickedImage.path);
        switch (numberImage) {
          case 1:
            imagePick1 = imageFile;
            break;
          case 2:
            imagePick2 = imageFile;
            break;
          case 3:
            imagePick3 = imageFile;
            break;
        }
      });
    }
  }

  void openBottomSheet(BuildContext context, int numberImage) {
    showAdaptiveActionSheet(
      context: context,
      androidBorderRadius: 30,
      bottomSheetColor: Colors.white,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: const Text('Camera'),
          onPressed: (context) {
            context.pop();
            uploadImageFromCameraOrGallery(ImageSource.camera, numberImage);
          },
        ),
        BottomSheetAction(
          title: const Text('Gallery'),
          onPressed: (context) {
            context.pop();
            uploadImageFromCameraOrGallery(ImageSource.gallery, numberImage);
          },
        ),
      ],
      cancelAction: CancelAction(
        title: const Text('Cancel'),
      ),
    );
  }

  int? categoryId;
  @override
  void initState() {
    super.initState();
    final cubit = SellerCubit.get(context);
    cubit.productNameController.text = widget.product.data!.name ?? '';
    cubit.productDescriptionController.text =
        widget.product.data!.description ?? '';
    cubit.priceController.text = widget.product.data!.price.toString();
    cubit.discountController.text = widget.product.data!.discount.toString();
    cubit.expirydateController.text = widget.product.data!.expiryDate ?? '';
    cubit.quantityController.text =
        widget.product.data!.availableQuantity.toString();
    categoryId = widget.product.data!.category!.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        if (state is EditSellerProductsSuccessState) {
          context.pop();
          SellerCubit.get(context).clearControllers();
          SellerCubit.get(context).getSellerProducts();
          showToast(
              message: 'Product Edited Successfully',
              state: TostStates.SUCCESS);
          categoryId = widget.product.data!.id;
        } else if (state is EditSellerProductsErrorState) {
          showToast(message: 'could not edit product', state: TostStates.ERROR);
        }
      },
      builder: (context, state) {
        final cubit = SellerCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.mainOrange,
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: ColorManager.mainOrange,
            leading: IconButton(
              onPressed: () {
                context.pop();
                // cubit.clearControllers();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            centerTitle: true,
            title: resuableText(
              text: "Edit Product",
              color: Colors.white,
              fontsize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        resuableText(
                          text: "Edit Product Images",
                          fontsize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildPickImage(
                              onPressed: () => openBottomSheet(context, 1),
                              image: imagePick1 == null
                                  ? (widget.product.data!.images != null &&
                                          widget
                                              .product.data!.images!.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              widget.product.data!.images![0]),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/image_picker_background.png'),
                                        ))
                                  : DecorationImage(
                                      image: FileImage(imagePick1!),
                                      fit: BoxFit.cover),
                            ),
                            Column(
                              children: [
                                buildPickImage(
                                  width: 125.w,
                                  height: 95.h,
                                  onPressed: () => openBottomSheet(context, 2),
                                  image: imagePick2 == null
                                      ? (widget.product.data!.images != null &&
                                              widget.product.data!.images!
                                                      .length >
                                                  1
                                          ? DecorationImage(
                                              image: NetworkImage(widget
                                                  .product.data!.images![1]),
                                              fit: BoxFit.cover)
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/image_picker_background.png'),
                                            ))
                                      : DecorationImage(
                                          image: FileImage(imagePick2!),
                                          fit: BoxFit.cover),
                                ),
                                buildPickImage(
                                  width: 125.w,
                                  height: 95.h,
                                  onPressed: () => openBottomSheet(context, 3),
                                  image: imagePick3 == null
                                      ? (widget.product.data!.images != null &&
                                              widget.product.data!.images!
                                                      .length >
                                                  2
                                          ? DecorationImage(
                                              image: NetworkImage(widget
                                                  .product.data!.images![2]),
                                              fit: BoxFit.cover)
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/image_picker_background.png'),
                                            ))
                                      : DecorationImage(
                                          image: FileImage(imagePick3!),
                                          fit: BoxFit.cover),
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(15),
                        AbsorbPointer(
                          absorbing: state is EditSellerProductsLoadingState
                              ? true
                              : false,
                          child: Form(
                            key: cubit.editProductFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                resuableText(
                                  text: "Edit Name",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: cubit.productNameController,
                                  isObsecureText: false,
                                  hintText: 'Product Name',
                                ),
                                verticalSpace(15),
                                resuableText(
                                  text: "Edit Description",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Description must not be empty';
                                    }
                                    return null;
                                  },
                                  controller:
                                      cubit.productDescriptionController,
                                  isObsecureText: false,
                                  hintText: 'Product Description',
                                  maxLines: 4,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                verticalSpace(15),
                                resuableText(
                                  text: "Choose Category",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                            bool isSelected =
                                                cubit.selectedCategoryId ==
                                                        category.id ||
                                                    categoryId == category.id;

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
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Price must not be empty';
                                              }
                                              return null;
                                            },
                                            controller: cubit.priceController,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          resuableText(
                                            text: "Discount",
                                            fontsize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Discount must not be empty';
                                              }
                                              return null;
                                            },
                                            controller:
                                                cubit.discountController,
                                            keyboardType: TextInputType.number,
                                            isObsecureText: false,
                                            hintText: 'Discount',
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Expiry Date must not be empty';
                                              }
                                              return null;
                                            },
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2030-05-01'),
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    cubit.expirydateController
                                                            .text =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(value);
                                                  });
                                                }
                                              });
                                            },
                                            readOnly: true,
                                            controller:
                                                cubit.expirydateController,
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
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Quantity must not be empty';
                                              }
                                              return null;
                                            },
                                            controller:
                                                cubit.quantityController,
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
                                  fontWeight: FontWeight.bold,
                                ),
                                Text('${widget.product.data!.availableFor}'),
                                verticalSpace(10),
                                resuableText(
                                  text: "Edit Available For",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter available for';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2030-05-01'),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          cubit.availableForController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(value);
                                        });
                                      }
                                    });
                                  },
                                  readOnly: true,
                                  controller: cubit.availableForController,
                                  keyboardType: TextInputType.datetime,
                                  isObsecureText: false,
                                  hintText: 'Available For',
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: AppTextButton(
                                textStyle: TextStyles.font17WhiteBold,
                                buttonText: 'Cancel',
                                onPressed: () {
                                  categoryId =
                                      widget.product.data!.category!.id;
                                  context.pop();
                                },
                              ),
                            ),
                            horizontalSpace(10),
                            Expanded(
                              child: AppTextButton(
                                textStyle: TextStyles.font17WhiteBold,
                                buttonText:
                                    state is EditSellerProductsLoadingState
                                        ? 'Loading...'
                                        : 'Save',
                                onPressed: () {
                                  if (cubit.editProductFormKey.currentState!
                                      .validate()) {
                                    if (categoryId == null) {
                                      showToast(
                                        message: 'Please Select Category',
                                        state: TostStates.ERROR,
                                      );
                                      return;
                                    }

                                    List<File> productImages = [];
                                    bool imagesPicked = imagePick1 != null ||
                                        imagePick2 != null ||
                                        imagePick3 != null;

                                    // Check if any image is picked, if yes, ensure all three are picked
                                    if (imagesPicked) {
                                      if (imagePick1 == null ||
                                          imagePick2 == null ||
                                          imagePick3 == null) {
                                        showToast(
                                          message: 'Please Select All Images',
                                          state: TostStates.ERROR,
                                        );
                                        return;
                                      } else {
                                        if (imagePick1 != null) {
                                          productImages.add(imagePick1!);
                                        }
                                        if (imagePick2 != null) {
                                          productImages.add(imagePick2!);
                                        }
                                        if (imagePick3 != null) {
                                          productImages.add(imagePick3!);
                                        }
                                      }
                                    }

                                    double price = double.parse(
                                        cubit.priceController.text);
                                    double discount = double.parse(
                                        cubit.discountController.text);
                                    double quantity = double.parse(
                                        cubit.quantityController.text);
                                    DateTime expiryDate =
                                        DateFormat('yyyy-MM-dd').parse(
                                            cubit.expirydateController.text);
                                    DateTime availableFor =
                                        DateFormat('yyyy-MM-dd').parse(
                                            cubit.availableForController.text);

                                    cubit.editSellerProduct(
                                      id: widget.product.data!.id!,
                                      name: cubit.productNameController.text,
                                      description: cubit
                                          .productDescriptionController.text,
                                      categoryId: categoryId!,
                                      price: price,
                                      discount: discount,
                                      expiryDate: expiryDate,
                                      availableFor: availableFor,
                                      quantity: quantity,
                                      images: productImages,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
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
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(color: ColorManager.mainOrange, width: 1.0),
            ),
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
