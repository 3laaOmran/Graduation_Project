import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: ColorManager.mainOrange,
        title: Text(
          'About App',
          style: TextStyles.font18White,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Two Way Deal ',
              style: TextStyles.font20blackbold,
            ),
            verticalSpace(5),
            Text(
              'Version 0.1',
              style: TextStyles.font13GreyBold,
            ),
            verticalSpace(30),
            const Image(
              image: AssetImage('assets/images/two_way_deal_icon.png'),
            ),
            verticalSpace(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.copyright,
                  color: Colors.grey,
                ),
                horizontalSpace(5),
                Text(
                  '2Way Deal Flutter Team',
                  style: TextStyles.font13GreyBold,
                ),
              ],
            ),
            verticalSpace(30),
            AppTextButton(
              horizontalPadding: 10,
              verticalPadding: 10,
              buttonWidth: double.maxFinite,
              buttonText: 'Licenses',
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
