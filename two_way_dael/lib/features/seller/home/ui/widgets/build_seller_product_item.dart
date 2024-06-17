import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/seller/home/data/models/Seller_products_model.dart';
import 'package:two_way_dael/features/seller/home/logic/cubit/seller_cubit.dart';

class BuildSellerProductItem extends StatelessWidget {
  final SellerProductData product;
  const BuildSellerProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerCubit, SellerStates>(
      listener: (context, state) {
        if (state is DeleteSellerProductsSuccessState) {
          showToast(
            message: 'Product Deleted Successfully, \n Refresh Products',
            state: TostStates.SUCCESS,
          );
        }
      },
      builder: (context, state) {
        // var cubit = SellerCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(8, 8),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: product.images!.isEmpty
                            ? const DecorationImage(
                                image: AssetImage(
                                    'assets/images/no_product_image.png'),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage(product.images![0]),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    if (product.discount != "0.00")
                      Positioned(
                        bottom: 20.h,
                        child: Container(
                          width: 70.w,
                          height: 20.h,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${product.discount!} off',
                              style: TextStyles.font12White,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              verticalSpace(10),
              Text(
                product.name!,
                style: TextStyles.font17BlackBold,
              ),
              verticalSpace(5),
              Row(
                children: [
                  Text(
                    '${product.netPrice} egp',
                    style: TextStyles.font13GreyBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  DeleteCircleAvatar(id: product.id!),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeleteCircleAvatar extends StatelessWidget {
  const DeleteCircleAvatar({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 30,
      child: CircleAvatar(
        backgroundColor: ColorManager.mainOrange,
        child: customIconButton(
          color: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: const Center(child: Text('Are you sure?')),
                content: const Text(
                    'Do you want to delete this product permanently?'),
                actions: [
                  AppTextButton(
                    buttonText: 'Yes',
                    textStyle: TextStyles.font12White,
                    onPressed: () {
                      SellerCubit.get(context).deleteSellerProduct(id: id);
                      Navigator.of(context).pop();
                      SellerCubit.get(context).getSellerProducts();
                    },
                    buttonWidth: 30,
                    buttonHeight: 15,
                  ),
                  AppTextButton(
                    buttonText: 'No',
                    textStyle: TextStyles.font12White,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    buttonWidth: 30,
                    buttonHeight: 15,
                  ),
                ],
              ),
            );
          },
          icon: Icons.close,
          toolTip: 'Delete',
          size: 25,
        ),
      ),
    );
  }
}
