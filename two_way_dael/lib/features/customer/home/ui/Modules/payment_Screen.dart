import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/custom_icon_button.dart';
import 'package:two_way_dael/core/widgets/custom_text_form_field.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    super.key,
  });
  // final CheckoutModel checkoutModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is PaymentErrorState) {
          showToast(message: 'Payment Success', state: TostStates.SUCCESS);
          // showDialog(
          //     context: context,
          //     builder: (context) => const AlertDialog(
          //           title: Text('Payment Success'),
          //           content: Image(image: AssetImage('assets/images/done.png')),
          //         ));
          context.pushNamed(Routes.homeScreen);
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var formKey = GlobalKey<FormState>();
        var cardDetailsController = TextEditingController();
        var cardNameController = TextEditingController();
        var cvvController = TextEditingController();
        var expiryController = TextEditingController();
        return Scaffold(
          backgroundColor: ColorManager.notificationColor,
          appBar: AppBar(
            backgroundColor: ColorManager.mainOrange,
            toolbarHeight: 80,
            title: Text(
              'Payment',
              style: TextStyles.font20Whitebold.copyWith(fontSize: 25),
            ),
            leading: customIconButton(
              toolTip: 'back',
              onPressed: () {
                context.pop();
              },
              icon: Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(100),
                    Text('Enter your card details',
                        style: TextStyles.font15BlackBold),
                    verticalSpace(5),
                    CustomTextFormField(
                      controller: cardDetailsController,
                      isObsecureText: false,
                      hintText: '000 0000 0000 0000',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your card number';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expiry Date',
                                  style: TextStyles.font15BlackBold),
                              verticalSpace(5),
                              CustomTextFormField(
                                controller: expiryController,
                                isObsecureText: false,
                                hintText: 'MM/YY',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your card expiry date';
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CVV', style: TextStyles.font15BlackBold),
                              verticalSpace(5),
                              CustomTextFormField(
                                controller: cvvController,
                                isObsecureText: false,
                                hintText: 'CVV',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your card cvv';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                    Text('Name on card', style: TextStyles.font15BlackBold),
                    verticalSpace(5),
                    CustomTextFormField(
                      controller: cardNameController,
                      isObsecureText: false,
                      hintText: 'Name on card',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your card name';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(50),
                    AppTextButton(
                        buttonText: 'Pay',
                        textStyle: TextStyles.font17WhiteBold,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.payment(
                                expiry: expiryController.text,
                                cardNumber:
                                    int.parse(cardDetailsController.text),
                                cvv: cvvController.text,
                                invoiceId: 2,
                                orderId: 25);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
