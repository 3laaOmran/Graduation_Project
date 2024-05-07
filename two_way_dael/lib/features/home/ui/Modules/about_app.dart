import 'package:flutter/material.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  bool aboutUs = false;

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
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/main_background.png'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpace(70),
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
                  buttonText: 'About Us',
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  onPressed: () {
                    setState(() {
                      aboutUs = !aboutUs;
                    });
                  },
                ),
                verticalSpace(20),
                aboutUs
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2Way Deal Overview :-',
                            style: TextStyles.font17BlackBold,
                          ),
                          Text(
                            'Our application aims to reduce food waste by selling it at lower price than its original cost or donating it. We strive to minimize food loss and promote affordability, benefiting both consumers and the environment.',
                            style: TextStyles.font15BlackBold,
                          ),
                          verticalSpace(10),
                          Text(
                            'Our Goals :-',
                            style: TextStyles.font17BlackBold,
                          ),
                          Text(
                            '1- Reduce food waste by 30% within the first year of implementation, as measured by the total weight of unsold food items.',
                            style: TextStyles.font15BlackBold,
                          ),
                          Text(
                            '2- Increase the accessibility of affordable food options by offering discounted prices, leading to 20% increase in customer.',
                            style: TextStyles.font15BlackBold,
                          ),
                          Text(
                            '3- participation within six months. Collaborate with local food banks and charities to donate surplus food, aiming to distribute a minimum of 500 meals per month to those in need.',
                            style: TextStyles.font15BlackBold,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
