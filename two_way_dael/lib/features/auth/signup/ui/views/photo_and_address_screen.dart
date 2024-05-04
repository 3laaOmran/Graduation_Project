import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/helpers/spacing.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/resuable_text.dart';
import 'package:two_way_dael/features/auth/signup/logic/cubit/siginup_cubit.dart';
import 'package:two_way_dael/features/auth/signup/ui/widgets/build_drop_down_list.dart';

class PhotoAndAddressScreen extends StatelessWidget {
  const PhotoAndAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocBuilder<SignupCubit, SignupStates>(
        builder: (context, state) {
          var cubit = SignupCubit.get(context);
          List<String> governoratesList = [
            'Cairo',
            'Alexandria',
            'ElBehira',
            'Giza',
            'Aswan',
            'Banha',
          ];
          List<String> citiesList = [
            'Abohomoss',
            'El8Pzor',
            'KafrEldawar',
            'Balakter',
            'Elgenawia',
            'Dsoness',
          ];
          String selectedGovernorate = 'ElBehira';
          String selectedCity = 'Balakter';
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/main_background.png'),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(100),
                        Text(
                          'Last Step',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 30.0),
                        ),
                        Text(
                          'Add more details',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        verticalSpace(40),
                        Text(
                          'Add Your Profile Photo',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  fontSize: 19.0, fontWeight: FontWeight.w100),
                        ),
                        verticalSpace(10),
                        SizedBox(
                          width: 250,
                          height: 180,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 240.0,
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: cubit.imagePick == null
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/image_picker_background.png'),
                                              fit: BoxFit.none)
                                          : DecorationImage(
                                              image:
                                                  FileImage(cubit.imagePick!)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0)),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25.0)),
                                    border: Border.all(
                                        color: ColorManager.mainOrange,
                                        width: 1.0)),
                                child: CircleAvatar(
                                  radius: 17.0,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.pickImage();
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20.0,
                                      color: ColorManager.mainOrange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            resuableText(
                              text: "Governorate",
                              fontsize: 17.sp,
                            ),
                            buildDropDownList(
                              list: governoratesList,
                              selectedItem:selectedGovernorate,
                            ),
                            verticalSpace(30),
                            resuableText(
                              text: "City",
                              fontsize: 17.sp,
                            ),
                            buildDropDownList(
                              list: citiesList,
                              selectedItem:selectedCity,
                            ),
                          ],
                        ),
                        verticalSpace(50),
                        AppTextButton(
                          buttonText: 'Next',
                          textStyle: TextStyles.font20Whitebold,
                          onPressed: () {
                            context.pushNamedAndRemoveUntil(
                              Routes.homeScreen,
                              predicate: (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}