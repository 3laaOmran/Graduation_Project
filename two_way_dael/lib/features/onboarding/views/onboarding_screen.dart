import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/features/onboarding/widgets/build_boarding_screen.dart';
import 'package:two_way_dael/features/onboarding/widgets/onboarding_model_list.dart';
import '../../../core/helpers/cash_helper.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/custom_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  var boardController = PageController();
  bool isLast = false;
  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        context.pushNamedAndRemoveUntil(
          Routes.chooseAccountTypeScreen,
          predicate: (route) => false,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (int index) {
                          if (index == onboardingContentList.length - 1) {
                            setState(() {
                              isLast = true;
                            });
                          } else {
                            setState(() {
                              isLast = false;
                            });
                          }
                        },
                        controller: boardController,
                        itemBuilder: ((context, index) =>
                            buildBoardingScreen(onboardingContentList[index])),
                        itemCount: onboardingContentList.length,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        SmoothPageIndicator(
                          controller: boardController,
                          effect: const ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: ColorManager.mainOrange,
                            dotHeight: 10,
                            dotWidth: 10,
                            expansionFactor: 4,
                            spacing: 5,
                          ),
                          count: onboardingContentList.length,
                        ),
                        // const Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 40.h, horizontal: 20.w),
                          child: AppTextButton(
                            buttonText: isLast ? 'Get Started' : 'Next',
                            textStyle: TextStyles.font20Whitebold,
                            onPressed: () {
                              if (isLast) {
                                submit();
                              } else {
                                boardController.nextPage(
                                    duration: const Duration(
                                      milliseconds: 750,
                                    ),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: submit,
                child: const Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
