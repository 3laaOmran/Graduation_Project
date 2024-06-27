import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/ui/Modules/payment_Screen.dart';
import '../../../../../core/theming/colors.dart';
import '../../logic/cubit/customer_cubit.dart';
import '../../logic/cubit/customer_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is CheckoutErrorState) {
          showToast(message: 'Order Created', state: TostStates.SUCCESS);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PaymentScreen(
                    // checkoutModel: state.checkoutModel!,
                  )));
        }
      },
      builder: (context, state) {
        final cubit = CustomerCubit.get(context);
        var formKey = GlobalKey<FormState>();
        var addressController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            toolbarHeight: 80,
            title: Text(
              'My Cart',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 23.0,
                  color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    cubit.clearCart();
                    // CashHelper.removeData(key: 'totalPrice');
                  },
                  child: const Image(
                    image: AssetImage('assets/images/delete.png'),
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
          body: cubit.cartProducts.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/empty_cart.png'),
                    Text(
                      'Empty Cart\nGo add some products',
                      style: TextStyles.font17BlackBold.copyWith(height: 2),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                        itemBuilder: (context, index) =>
                            itemBottomSheet(context, index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.0.h,
                        ),
                        itemCount: cubit.cartProducts.length,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 220.0.h,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    'Total Price:',
                                    style: TextStyles.font30blackbold
                                        .copyWith(fontSize: 25),
                                  ),
                                  horizontalSpace(10),
                                  Text(
                                    cubit.getTotalPrice().toStringAsFixed(2),
                                    style: TextStyles.font28MainOrangeBold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  horizontalSpace(10),
                                  Text(
                                    'EGP',
                                    style: TextStyles.font17BlackBold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(10),
                            Form(
                              key: formKey,
                              child: CustomTextFormField(
                                isObsecureText: false,
                                hintText: 'Address',
                                controller: addressController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            verticalSpace(10),
                            AppTextButton(
                              textStyle: TextStyles.font17WhiteBold,
                              buttonText: 'Check Out',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final products = {
                                    for (var product in cubit.cartProducts)
                                      product.id: {
                                        'id': product.id,
                                        'name': product.name,
                                        'quantity': product.quantity,
                                        'price': product.netPrice,
                                        'image': product.images!.isNotEmpty
                                            ? product.images![0]
                                            : null,
                                      }
                                  };

                                  cubit.checkout(
                                    shipping: false,
                                    address: addressController.text,
                                    totalPrice: cubit.getTotalPrice(),
                                    products: products,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget itemBottomSheet(BuildContext context, int index) {
    final cubit = CustomerCubit.get(context);

    final product = cubit.cartProducts[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 85.0.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(8, 8),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
                child: Row(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: SizedBox(
                        height: 68.0.h,
                        width: 65.0.w,
                        child: product.images!.isNotEmpty
                            ? Image.network(
                                product.images![1],
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/no_product_image.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    horizontalSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? '',
                            style: TextStyles.font17BlackBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cubit.minus(product);
                                        },
                                        child: Container(
                                          width: 30.0.w,
                                          height: 30.0.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1.5.w,
                                              color: ColorManager.gray,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        '${product.quantity}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                      ),
                                      horizontalSpace(5),
                                      InkWell(
                                        onTap: () {
                                          cubit.plus(product);
                                        },
                                        child: Container(
                                          width: 30.0.w,
                                          height: 30.0.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1.5.w,
                                              color: ColorManager.gray,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        (double.parse(product.netPrice!) *
                                                product.quantity)
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[800],
                                                fontSize: 13.0,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        'EGP',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                              fontSize: 10.0,
                                            ),
                                      ),
                                      horizontalSpace(10)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {
                cubit.removeFromCart(product);
              },
              child: const Icon(
                Icons.delete_outlined,
                size: 35.0,
                color: ColorManager.mainOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
