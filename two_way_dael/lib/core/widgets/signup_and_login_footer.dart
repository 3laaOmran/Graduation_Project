import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theming/styles.dart';

class SignupAndLoginFooter extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function() ontap;
  const SignupAndLoginFooter(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: TextStyles.font15BlackRegular,
            ),
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = ontap,
                text: secondText,
                style: TextStyles.font15MainOrangeRegular),
          ],
        ),
      ),
    );
  }
}
