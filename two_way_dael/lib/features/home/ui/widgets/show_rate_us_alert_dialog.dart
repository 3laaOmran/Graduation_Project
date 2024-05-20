import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_toast.dart';

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Center(
          child: Text(
        'Rate Us',
        style: TextStyle(
          color: ColorManager.mainOrange,
          fontWeight: FontWeight.bold,
        ),
      )),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          heightFactor: BorderSide.strokeAlignCenter,
          child: RatingBarIndicator(
            rating: 0,
            itemCount: 5,
            itemSize: 25.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: ColorManager.mainOrange,
            ),
          ),
        ),
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
                    message: 'sent succesfully', state: TostStates.others);
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