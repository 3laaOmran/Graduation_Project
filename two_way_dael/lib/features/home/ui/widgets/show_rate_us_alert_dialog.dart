import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';

class ShowAlertDialog extends StatefulWidget {
  const ShowAlertDialog({
    super.key,
  });

  @override
  State<ShowAlertDialog> createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
                Navigator.of(context).pop();
                showToast(
                    message: 'Rating sent successfully',
                    state: TostStates.others);
                // You can use 'rating' variable here to send the rating to your backend or perform any other action
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
  }
}
