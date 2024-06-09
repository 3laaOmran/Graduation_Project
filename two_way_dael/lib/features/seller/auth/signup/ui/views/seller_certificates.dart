import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_way_dael/core/constants/constants.dart';
import 'package:two_way_dael/core/helpers/cash_helper.dart';
import 'package:two_way_dael/core/helpers/extensions.dart';
import 'package:two_way_dael/core/routing/routes.dart';
import 'package:two_way_dael/core/theming/colors.dart';
import 'package:two_way_dael/core/theming/styles.dart';
import 'package:two_way_dael/core/widgets/custom_button.dart';
import 'package:two_way_dael/core/widgets/show_snackbar.dart';
import 'package:two_way_dael/features/seller/auth/signup/logic/cubit/seller_signup_cubit.dart';

import '../../../../../../core/helpers/spacing.dart';

class SellerCertificates extends StatelessWidget {
  const SellerCertificates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerSignupCubit(),
      child: BlocConsumer<SellerSignupCubit, SellerSignupStates>(
        listener: (context, state) {
          if (state is SellerCertificatesLoadingState) {
            CashHelper.getData(key: 'sellerRegisterToken');
          } else if (state is SellerCertificatesSuccessState) {
            if (state.certificatesModel.status == 200) {
              showSnackBar(context, message: state.certificatesModel.message!);
              // showToast(
              //     message: state.certificatesModel.message!,
              //     state: TostStates.SUCCESS);
              context.pushNamedAndRemoveUntil(Routes.sellerLoginScreen,
                  predicate: (route) => false);
              // CashHelper.saveData(
              //         key: 'sellerToken', value: sellerRegisterToken)
              //     .then((value) {
              // sellerToken = sellerRegisterToken;
              // });
            }
          } else if (state is SellerCertificatesErrorState) {
           showSnackBar(context, message: state.error);
          }
        },
        builder: (context, state) {
          var cubit = SellerSignupCubit.get(context);
          return SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main_background.png'),
                    fit: BoxFit.cover),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: AbsorbPointer(
                        absorbing: state is SellerPhotoAndAddressLoadingState
                            ? true
                            : false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(80),
                            Text(
                              'Last Step',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30.0),
                            ),
                            Text(
                              'Add Your Certificates',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                            ),
                            verticalSpace(40),
                            Text(
                              'Add Health Approval Certificate',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold),
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
                                          image: cubit.healthCertificate == null
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/image_picker_background.png'),
                                                  fit: BoxFit.none)
                                              : DecorationImage(
                                                  image: FileImage(cubit
                                                      .healthCertificate!)),
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
                                          cubit.pickHealthCertificate();
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
                            verticalSpace(30),
                            Text(
                              'Add Commercial License',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold),
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
                                          image: cubit.commercialLicense == null
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/image_picker_background.png'),
                                                  fit: BoxFit.none)
                                              : DecorationImage(
                                                  image: FileImage(cubit
                                                      .commercialLicense!)),
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
                                          cubit.pickCommercialLicense();
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
                            verticalSpace(30),
                            state is! SellerCertificatesLoadingState
                                ? AppTextButton(
                                    buttonText: 'Finish',
                                    textStyle: TextStyles.font17WhiteBold,
                                    onPressed: () {
                                      if (cubit.healthCertificate == null) {
                                        showSnackBar(context,
                                            message:
                                                'Please, Add your health certificate');
                                        return;
                                      }
                                      if (cubit.commercialLicense == null) {
                                        showSnackBar(context,
                                            message:
                                                'Please, Add your commercial license');
                                        return;
                                      }
                                      debugPrint(
                                          'Health: ${cubit.healthCertificate}');
                                      debugPrint(
                                          'Health: ${cubit.commercialLicense}');
                                      // cubit.uploadCertificates(
                                      //   token: sellerRegisterToken!,
                                      //   healthCertificate: cubit.healthCertificate,
                                      //   commercialLicense: cubit.commercialLicense,
                                      // );
                                      cubit.certificates(
                                        token: sellerRegisterToken!,
                                        healthCertificate:
                                            cubit.healthCertificate,
                                        commercialLicense:
                                            cubit.commercialLicense,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorManager.mainOrange,
                                    ),
                                  ),
                            verticalSpace(30),
                          ],
                        ),
                      ),
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
