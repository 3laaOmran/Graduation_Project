import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_cubit.dart';
import 'package:two_way_dael/features/customer/home/logic/cubit/customer_states.dart';

class ShowAlertDialog extends StatefulWidget {
  const ShowAlertDialog({
    super.key,
    required this.storeId,
  });

  final int storeId;

  @override
  State<ShowAlertDialog> createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {
        if (state is CustomerRateSellersSuccessState) {
          Navigator.of(context).pop();
          showToast(
              message: 'Rating sent successfully', state: TostStates.SUCCESS);
        } else if (state is CustomerRateSellersErrorState) {
          showToast(message: 'can not send rating', state: TostStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = CustomerCubit.get(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Your Review',
              style: TextStyle(
                color: ColorManager.mainOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: RatingBar.builder(
                  initialRating: rating,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 30.0,
                  updateOnDrag: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: ColorManager.mainOrange,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating; // Update rating value
                    });
                  },
                ),
              ),
              Text(
                '$rating stars',
                style: TextStyles.font13GreyBold,
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextButton(
                  buttonText: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                    showToast(message: '😢', state: TostStates.others);
                  },
                  buttonWidth: 80,
                  verticalPadding: 0,
                  buttonHeight: 30,
                  textStyle: TextStyles.font12White,
                ),
                horizontalSpace(20),
                AppTextButton(
                  buttonText: 'Send',
                  onPressed: () {
                    cubit.rateSeller(
                      id: widget.storeId,
                      rate: rating.toInt(),
                    );
                  },
                  buttonWidth: 80,
                  verticalPadding: 0,
                  buttonHeight: 30,
                  textStyle: TextStyles.font12White,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
