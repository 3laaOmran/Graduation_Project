import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/features/onboarding/widgets/background_code.dart';
import 'package:two_way_dael/features/onboarding/widgets/onboarding_model_list.dart';

Widget buildBoardingScreen(OnboardingContentModel onboardingContentList) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned(
                left: 110,
                right: -128,
                child: CustomPaint(
                  size: Size(
                      double.infinity, (454 * 0.9354120467015411.h).toDouble()),
                  painter: BackgroundCode(),
                ),
              ),
              Image(
                image: AssetImage(onboardingContentList.image),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                onboardingContentList.mainText,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                onboardingContentList.bodyText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
