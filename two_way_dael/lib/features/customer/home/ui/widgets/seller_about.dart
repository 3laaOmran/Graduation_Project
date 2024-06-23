import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';
import 'package:two_way_dael/features/customer/home/ui/widgets/show_rate_us_alert_dialog.dart';

import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/custom_button.dart';

class SellerAbout extends StatelessWidget {
  const SellerAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerStates>(
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        var store = cubit.productDetails!.data!.product!.store;
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              Text(
                'Customer Reviews',
                style: TextStyles.font20blackbold,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        RatingBarIndicator(
                          rating: double.tryParse(store!.rate!) ?? 0.0,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: ColorManager.mainOrange,
                          ),
                        ),
                        verticalSpace(5),
                        Text(
                          '${store.rateWithReviews}',
                          style: TextStyles.font13GreyBold,
                        ),
                      ],
                    ),
                    const Spacer(),
                    AppTextButton(
                      buttonWidth: 110,
                      buttonHeight: 30,
                      verticalPadding: 0,
                      textStyle: TextStyles.font12White,
                      buttonText: 'Send Review',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  ShowAlertDialog(storeId: store.id!,);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              Text(
                'About',
                style: TextStyles.font20blackbold,
              ),
              verticalSpace(20),
              richText(
                text1: 'Address: ',
                text2: ' ${store.address}',
              ),
              verticalSpace(20),
              richText(
                text1: 'Contacts: ',
                text2: ' ${store.phone}',
              ),
              verticalSpace(20),
            ],
          ),
        );
      },
    );
  }
}

Widget richText({
  required String text1,
  required String text2,
}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(text: text1, style: TextStyles.font17BlackBold),
        TextSpan(text: text2, style: TextStyles.font17BlackBold),
      ],
    ),
  );
}
