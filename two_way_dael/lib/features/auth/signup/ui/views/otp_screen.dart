import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/features/auth/signup/ui/widgets/otp_text_field.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_button.dart';

class ConfirmAccount extends StatefulWidget {
  const ConfirmAccount({super.key});
  @override
  State<ConfirmAccount> createState() => _ConfirmAccountState();
}

class _ConfirmAccountState extends State<ConfirmAccount> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();

  var controller4 = TextEditingController();

  bool isFilled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/main_background.png'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.homeScreen);
                    },
                    child: Image.asset(
                      'assets/images/arrow.png',
                      width: 60.w,
                    ),
                  ),
                  verticalSpace(50),
                  Text(
                    'Confirm Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w900, fontSize: 30.0),
                  ),
                  verticalSpace(5),
                  Text(
                    'we\'ve sent you code to your Email',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  verticalSpace(45),
                  Text(
                    'Your Code',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 19.0, fontWeight: FontWeight.w100),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OTPTextField(
                        controller: c1,
                        first: true,
                        last: false,
                      ),
                      OTPTextField(
                        controller: c2,
                        first: false,
                        last: false,
                      ),
                      OTPTextField(
                        controller: c3,
                        first: false,
                        last: false,
                      ),
                      OTPTextField(
                        controller: c4,
                        first: false,
                        last: false,
                      ),
                    ],
                  ),
                  verticalSpace(15),
                  Text(
                    "didn't receive anything?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w900, fontSize: 16.0),
                  ),
                  verticalSpace(25),
                  AppTextButton(
                    buttonText: 'Next',
                    textStyle: TextStyles.font20Whitebold,
                    onPressed: () {
                      context.pushNamed(Routes.homeScreen);
                    },
                  ),
                  verticalSpace(15),
                  Center(
                    child: Text(
                      'by clicking "Next" you agree to our\n terms of service and privacy statement',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 15.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    super.dispose();
  }
}
